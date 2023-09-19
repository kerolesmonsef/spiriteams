<?php

namespace App\Http\Controllers\Admin;

use App\Helper\Reply;
use App\Http\Requests\TaskBoard\StoreTaskBoard;
use App\Http\Requests\TaskBoard\UpdateTaskBoard;
use App\Jobs\TaskJob;
use App\Project;
use App\Services\TaskBoardColumnService;
use App\Task;
use App\TaskboardColumn;
use App\TaskCategory;
use App\TaskLabelList;
use App\User;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AdminTaskboardController extends AdminBaseController
{
    private TaskBoardColumnService $taskBoardColumnService;

    public function __construct()
    {
        parent::__construct();
        $this->pageTitle = 'modules.tasks.taskBoard';
        $this->pageIcon = 'ti-layout-column3';
        $this->middleware(function ($request, $next) {
            if (!in_array('tasks', $this->user->modules)) {
                abort(403);
            }

            return $next($request);
        });

        $this->taskBoardColumnService = app(TaskBoardColumnService::class);
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
            ->leftJoin('task_labels', 'task_labels.task_id', '=', 'tasks.id')
            ->leftJoin('users as creator_user', 'creator_user.id', '=', 'tasks.created_by')
            ->select('tasks.*')
            ->groupBy('tasks.id')
            ->whereNull('projects.deleted_at')
            ->where("tasks.board_column_id", $taskboard_column_id)
            ->orderBy('column_priority');

        $q->where(function (Builder $q) use ($startDate, $endDate) {
            $q->whereBetween(DB::raw('DATE(tasks.`due_date`)'), [$startDate, $endDate]);
            $q->orWhereBetween(DB::raw('DATE(tasks.`start_date`)'), [$startDate, $endDate]);
        });

        if ($request->projectID != 0 && $request->projectID != null && $request->projectID != 'all') {
            $q->where('tasks.project_id', '=', $request->projectID);
        }

        if ($request->clientID != '' && $request->clientID != null && $request->clientID != 'all') {
            $q->where('projects.client_id', '=', $request->clientID);
        }

        if ($request->assignedTo != '' && $request->assignedTo != null && $request->assignedTo != 'all') {
            $q->where('task_users.user_id', '=', $request->assignedTo);
        }

        if ($request->assignedBY != '' && $request->assignedBY != null && $request->assignedBY != 'all') {
            $q->where('creator_user.id', '=', $request->assignedBY);
        }

        if ($request->category_id != '' && $request->category_id != null && $request->category_id != 'all') {
            $q->where('tasks.task_category_id', '=', $request->category_id);
        }
        if ($request->label_id != '' && $request->label_id != null && $request->label_id != 'all') {
            $q->where('task_labels.label_id', '=', $request->label_id);
        }

        $q->offset($offset)->limit($limit + 1);

        $tasks = $q->get();
        $countPlus1 = $tasks->count();
        $tasks->offsetUnset($limit);

        return response()->json([
            'taskboard_column_id' => $taskboard_column_id,
            'next_offset' => $offset + $limit,
            'thereIsMore' => $countPlus1 > $limit,
            'tasks' => view('admin.taskboard.Components.board_column_tasks', [
                'tasks' => $tasks,
                'global' => $this->global,
            ])->render(),
        ]);
    }

    public function index_2(Request $request)
    {
        $this->startDate = Carbon::now()->subDays(15)->format($this->global->date_format);
        $this->endDate = Carbon::now()->addDays(15)->format($this->global->date_format);
        $this->projects = Project::allProjects();
        $this->clients = User::allClients();
        $this->employees = User::allEmployees();
        $this->publicTaskboardLink = encrypt($this->companyName);
        $this->taskCategories = TaskCategory::all();
        $this->taskLabels = TaskLabelList::all();
        $this->boardColumns = TaskboardColumn::query()->orderBy("priority")->get();
        $this->boardColumnsIds = $this->boardColumns->pluck("id");
        $this->boardEdit = (request()->has('boardEdit') && request('boardEdit') == 'false') ? false : true;
        $this->boardDelete = (request()->has('boardDelete') && request('boardDelete') == 'false') ? false : true;


        return view('admin.taskboard.index_2', $this->data);
    }


    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $this->startDate = Carbon::now()->subDays(15)->format($this->global->date_format);
        $this->endDate = Carbon::now()->addDays(15)->format($this->global->date_format);
        $this->projects = Project::allProjects();
        $this->clients = User::allClients();
        $this->employees = User::allEmployees();
        $this->publicTaskboardLink = encrypt($this->companyName);
        $this->taskCategories = TaskCategory::all();
        $this->taskLabels = TaskLabelList::all();
        $this->projectId = $request->projectID;
        if (request()->ajax()) {

            $startDate = Carbon::createFromFormat($this->global->date_format, $request->startDate)->toDateString();
            $endDate = Carbon::createFromFormat($this->global->date_format, $request->endDate)->toDateString();

            $this->boardEdit = (request()->has('boardEdit') && request('boardEdit') == 'false') ? false : true;
            $this->boardDelete = (request()->has('boardDelete') && request('boardDelete') == 'false') ? false : true;

            $boardColumns = TaskboardColumn::with(['tasks' => function ($q) use ($startDate, $endDate, $request) {
                $q->with(['subtasks', 'completedSubtasks', 'comments', 'users', 'project', 'label'])
                    ->leftJoin('projects', 'projects.id', '=', 'tasks.project_id')
                    ->leftJoin('users as client', 'client.id', '=', 'projects.client_id')
                    ->join('task_users', 'task_users.task_id', '=', 'tasks.id')
                    ->join('users', 'task_users.user_id', '=', 'users.id')
                    ->leftJoin('task_labels', 'task_labels.task_id', '=', 'tasks.id')
                    ->leftJoin('users as creator_user', 'creator_user.id', '=', 'tasks.created_by')
                    ->select('tasks.*')
                    ->groupBy('tasks.id');

                $q->where(function ($task) use ($startDate, $endDate) {
                    $task->whereBetween(DB::raw('DATE(tasks.`due_date`)'), [$startDate, $endDate]);

                    $task->orWhereBetween(DB::raw('DATE(tasks.`start_date`)'), [$startDate, $endDate]);
                });
                $q->whereNull('projects.deleted_at');

                if ($request->projectID != 0 && $request->projectID != null && $request->projectID != 'all') {
                    $q->where('tasks.project_id', '=', $request->projectID);
                }

                if ($request->clientID != '' && $request->clientID != null && $request->clientID != 'all') {
                    $q->where('projects.client_id', '=', $request->clientID);
                }

                if ($request->assignedTo != '' && $request->assignedTo != null && $request->assignedTo != 'all') {
                    $q->where('task_users.user_id', '=', $request->assignedTo);
                }

                if ($request->assignedBY != '' && $request->assignedBY != null && $request->assignedBY != 'all') {
                    $q->where('creator_user.id', '=', $request->assignedBY);
                }

                if ($request->category_id != '' && $request->category_id != null && $request->category_id != 'all') {
                    $q->where('tasks.task_category_id', '=', $request->category_id);
                }
                if ($request->label_id != '' && $request->label_id != null && $request->label_id != 'all') {
                    $q->where('task_labels.label_id', '=', $request->label_id);
                }
            }])->orderBy('priority', 'asc')->get();

            $this->boardColumns = $boardColumns;

            $this->startDate = $startDate;
            $this->endDate = $endDate;

            $view = view('admin.taskboard.board_data', $this->data)->render();
            return Reply::dataOnly(['view' => $view]);
        }

        return view('admin.taskboard.index', $this->data);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('admin.taskboard.create', $this->data);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreTaskBoard $request)
    {
        $this->taskBoardColumnService->store($request);

        return Reply::redirect(route('admin.taskboard.index_2'), __('messages.boardColumnSaved'));
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
        $view = view('admin.taskboard.edit', $this->data)->render();
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
        $this->taskBoardColumnService->update($request, $id);

        return Reply::redirect(route('admin.taskboard.index_2'), __('messages.boardColumnSaved'));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $this->taskBoardColumnService->destroy($id);

        return Reply::dataOnly(['status' => 'success']);
    }

    public function updateIndex(Request $request)
    {

        $taskIds = $request->taskIds;
        $boardColumnIds = $request->boardColumnIds;
        $priorities = $request->prioritys;

        $board = TaskboardColumn::findOrFail($boardColumnIds[0]);

        TaskJob::dispatch($board, $boardColumnIds, $priorities, $taskIds);

        return Reply::dataOnly(['status' => 'success']);
    }
}
