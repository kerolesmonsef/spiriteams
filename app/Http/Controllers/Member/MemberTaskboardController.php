<?php

namespace App\Http\Controllers\Member;

use App\Helper\Reply;
use App\Http\Requests\TaskBoard\StoreTaskBoard;
use App\Http\Requests\TaskBoard\UpdateTaskBoard;
use App\Jobs\TaskJob;
use App\Project;
use App\Task;
use App\TaskboardColumn;
use App\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class MemberTaskboardController extends MemberBaseController
{
    public function __construct()
    {
        parent::__construct();
        $this->pageTitle = 'modules.tasks.taskBoard';
        $this->pageIcon = 'ti-layout-column3';
        $this->middleware(function ($request, $next) {
            if (!in_array('tasks', $this->modules)) {
                abort(403);
            }
            return $next($request);
        });
    }

    public function columnTasks(Request $request)
    {
        $startDate = Carbon::createFromFormat($this->global->date_format, $request->startDate)->toDateString();
        $endDate = Carbon::createFromFormat($this->global->date_format, $request->endDate)->toDateString();
        $taskboard_column_id = request('taskboard_column_id');
        $offset = request('offset', 0);
        $limit = request('limit', 10);

        $q = Task::query();

        $q->with(['subtasks', 'completedSubtasks', 'comments', 'users', 'project', 'label'])
            ->leftJoin('projects', 'projects.id', '=', 'tasks.project_id')
            ->leftJoin('users as client', 'client.id', '=', 'projects.client_id')
            ->join('task_users', 'task_users.task_id', '=', 'tasks.id')
            ->join('users', 'task_users.user_id', '=', 'users.id')
            ->join('taskboard_columns', 'taskboard_columns.id', '=', 'tasks.board_column_id')
            ->leftJoin('users as creator_user', 'creator_user.id', '=', 'tasks.created_by')
            ->select('tasks.*')
            ->groupBy('tasks.id')
            ->orderBy("column_priority")
            ->where("tasks.board_column_id", $taskboard_column_id);

        $q->whereNull('projects.deleted_at');

        $q->where(function ($task) use ($startDate, $endDate) {
            $task->whereBetween(DB::raw('DATE(tasks.`due_date`)'), [$startDate, $endDate]);

            $task->orWhereBetween(DB::raw('DATE(tasks.`start_date`)'), [$startDate, $endDate]);
        });

        if ($request->projectID != 0 && $request->projectID != null && $request->projectID != 'all') {
            $q = $q->where('tasks.project_id', '=', $request->projectID);
        }

        if ($request->clientID != '' && $request->clientID != null && $request->clientID != 'all') {
            $q = $q->where('projects.client_id', '=', $request->clientID);
        }

        if ($request->assignedTo != '' && $request->assignedTo != null && $request->assignedTo != 'all') {
            $q = $q->where('task_users.user_id', '=', $request->assignedTo);
        }

        if ($request->assignedBY != '' && $request->assignedBY != null && $request->assignedBY != 'all') {
            $q = $q->where('creator_user.id', '=', $request->assignedBY);
        }


        if (!$this->user->can('view_tasks')) {
            $q = $q->where(
                function ($q) {
                    $q->where(
                        function ($q1) {
                            $q1->where(
                                function ($q3) {
                                    $q3->where('tasks.is_private', 0);
                                    $q3->where('task_users.user_id', $this->user->id);
                                }
                            );
                            $q1->orWhere('tasks.created_by', $this->user->id);
                        }
                    );
                    $q->orWhere(
                        function ($q2) {
                            $q2->where('tasks.is_private', 1);
                            $q2->where('task_users.user_id', $this->user->id);
                        }
                    );
                }
            );
        }

        $q->offset($offset)->limit($limit + 1);


        $tasks = $q->get();
        $countPlus1 = $tasks->count();
        $tasks->offsetUnset($limit);


        return response()->json([
            'taskboard_column_id' => $taskboard_column_id,
            'next_offset' => $offset + $limit,
            'thereIsMore' => $countPlus1 > $limit,
            'tasks' => view('member.taskboard.Components.board_column_tasks', [
                'tasks' => $tasks,
                'global' => $this->global,
            ])->render(),
        ]);
    }

    public function index_2()
    {
        $this->startDate = Carbon::now()->timezone($this->global->timezone)->subDays(6)->format($this->global->date_format);
        $this->endDate = Carbon::now()->timezone($this->global->timezone)->addDays(7)->format($this->global->date_format);
        $this->projects = ($this->user->can('view_projects')) ? Project::orderBy('project_name', 'asc')->get() : Project::select('projects.*')->join('project_members', 'project_members.project_id', '=', 'projects.id')
            ->where('project_members.user_id', $this->user->id)
            ->orderBy('project_name', 'asc')
            ->get();
        $this->employees = ($this->user->can('view_employees')) ? User::allEmployees() : User::where('id', $this->user->id)->get();

        $this->clients = User::allClients();
        $this->boardColumns = TaskboardColumn::query()->orderBy("priority")->get();
        $this->boardColumnsIds = $this->boardColumns->pluck("id");

        return view('member.taskboard.index_2', $this->data);

    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     * @throws \Throwable
     */
    public function index(Request $request)
    {
        $this->startDate = Carbon::now()->timezone($this->global->timezone)->subDays(6)->format($this->global->date_format);
        $this->endDate = Carbon::now()->timezone($this->global->timezone)->addDays(7)->format($this->global->date_format);
        $this->projects = ($this->user->can('view_projects')) ? Project::orderBy('project_name', 'asc')->get() : Project::select('projects.*')->join('project_members', 'project_members.project_id', '=', 'projects.id')
            ->where('project_members.user_id', $this->user->id)
            ->orderBy('project_name', 'asc')
            ->get();
        $this->employees = ($this->user->can('view_employees')) ? User::allEmployees() : User::where('id', $this->user->id)->get();

        $this->clients = User::allClients();

        if ($request->ajax()) {
            $startDate = Carbon::createFromFormat($this->global->date_format, $request->startDate)->toDateString();
            $endDate = Carbon::createFromFormat($this->global->date_format, $request->endDate)->toDateString();

            $boardColumns = TaskboardColumn::with(['tasks' => function ($q) use ($startDate, $endDate, $request) {
                $q->with(['subtasks', 'completedSubtasks', 'comments', 'users', 'project', 'label'])
                    ->leftJoin('projects', 'projects.id', '=', 'tasks.project_id')
                    ->leftJoin('users as client', 'client.id', '=', 'projects.client_id')
                    ->join('task_users', 'task_users.task_id', '=', 'tasks.id')
                    ->join('users', 'task_users.user_id', '=', 'users.id')
                    ->join('taskboard_columns', 'taskboard_columns.id', '=', 'tasks.board_column_id')
                    ->leftJoin('users as creator_user', 'creator_user.id', '=', 'tasks.created_by')
                    ->select('tasks.*')
                    ->groupBy('tasks.id');

                $q->whereNull('projects.deleted_at');

                $q->where(function ($task) use ($startDate, $endDate) {
                    $task->whereBetween(DB::raw('DATE(tasks.`due_date`)'), [$startDate, $endDate]);

                    $task->orWhereBetween(DB::raw('DATE(tasks.`start_date`)'), [$startDate, $endDate]);
                });

                if ($request->projectID != 0 && $request->projectID != null && $request->projectID != 'all') {
                    $q = $q->where('tasks.project_id', '=', $request->projectID);
                }

                if ($request->clientID != '' && $request->clientID != null && $request->clientID != 'all') {
                    $q = $q->where('projects.client_id', '=', $request->clientID);
                }

                if ($request->assignedTo != '' && $request->assignedTo != null && $request->assignedTo != 'all') {
                    $q = $q->where('task_users.user_id', '=', $request->assignedTo);
                }

                if ($request->assignedBY != '' && $request->assignedBY != null && $request->assignedBY != 'all') {
                    $q = $q->where('creator_user.id', '=', $request->assignedBY);
                }


                if (!$this->user->can('view_tasks')) {
                    $q = $q->where(
                        function ($q) {
                            $q->where(
                                function ($q1) {
                                    $q1->where(
                                        function ($q3) {
                                            $q3->where('tasks.is_private', 0);
                                            $q3->where('task_users.user_id', $this->user->id);
                                        }
                                    );
                                    $q1->orWhere('tasks.created_by', $this->user->id);
                                }
                            );
                            $q->orWhere(
                                function ($q2) {
                                    $q2->where('tasks.is_private', 1);
                                    $q2->where('task_users.user_id', $this->user->id);
                                }
                            );
                        }
                    );
                }
            }])->orderBy('priority', 'asc')->get();

            $this->boardColumns = $boardColumns;

            $this->startDate = $startDate;
            $this->endDate = $endDate;

            $view = view('member.taskboard.board_data', $this->data)->render();
            return Reply::dataOnly(['view' => $view]);
        }

        return view('member.taskboard.index', $this->data);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('member.taskboard.create', $this->data);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreTaskBoard $request)
    {
        $maxPriority = TaskboardColumn::max('priority');

        $board = new TaskboardColumn();
        $board->column_name = $request->column_name;
        $board->label_color = $request->label_color;
        $board->priority = ($maxPriority + 1);
        $board->save();

        return Reply::redirect(route('member.taskboard.index'), __('messages.boardColumnSaved'));
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $this->boardColumn = TaskboardColumn::findOrFail($id);
        $this->maxPriority = TaskboardColumn::max('priority');
        $view = view('member.taskboard.edit', $this->data)->render();
        return Reply::dataOnly(['status' => 'success', 'view' => $view]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateTaskBoard $request, $id)
    {
        $board = TaskboardColumn::findOrFail($id);
        $oldPosition = $board->priority;
        $newPosition = $request->priority;

        if ($oldPosition < $newPosition) {

            $otherColumns = TaskboardColumn::where('priority', '>', $oldPosition)
                ->where('priority', '<=', $newPosition)
                ->orderBy('priority', 'asc')
                ->get();

            foreach ($otherColumns as $column) {
                $pos = TaskboardColumn::where('priority', $column->priority)->first();
                $pos->priority = ($pos->priority - 1);
                $pos->save();
            }
        } else if ($oldPosition > $newPosition) {

            $otherColumns = TaskboardColumn::where('priority', '<', $oldPosition)
                ->where('priority', '>=', $newPosition)
                ->orderBy('priority', 'asc')
                ->get();

            foreach ($otherColumns as $column) {
                $pos = TaskboardColumn::where('priority', $column->priority)->first();
                $pos->priority = ($pos->priority + 1);
                $pos->save();
            }
        }

        $board->column_name = $request->column_name;
        $board->label_color = $request->label_color;
        $board->priority = $request->priority;
        $board->save();

        return Reply::redirect(route('member.taskboard.index'), __('messages.boardColumnSaved'));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        Task::where('board_column_id', $id)->update(['board_column_id' => 1]);

        $board = TaskboardColumn::findOrFail($id);

        $otherColumns = TaskboardColumn::where('priority', '>', $board->priority)
            ->orderBy('priority', 'asc')
            ->get();

        foreach ($otherColumns as $column) {
            $pos = TaskboardColumn::where('priority', $column->priority)->first();
            $pos->priority = ($pos->priority - 1);
            $pos->save();
        }

        TaskboardColumn::destroy($id);

        return Reply::dataOnly(['status' => 'success']);
    }

    public function updateIndex(Request $request)
    {
        $taskIds = $request->taskIds;
        $boardColumnIds = $request->boardColumnIds;
        $priorities = $request->prioritys;

        $board = TaskboardColumn::findOrFail($boardColumnIds[0]);

        TaskJob::dispatch($board,$boardColumnIds, $priorities, $taskIds);

        return Reply::dataOnly(['status' => 'success']);
    }
}
