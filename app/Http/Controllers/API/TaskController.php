<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Requests\Tasks\StoreTask;
use App\Http\Resources\TaskBoardColumnResource;
use App\Http\Resources\TaskHistoryResource;
use App\Http\Resources\TaskResource;
use App\Jobs\TaskJobMobileApp;
use App\Services\TaskBoardColumnService;
use App\Services\TaskService;
use App\Task;
use App\TaskboardColumn;
use App\TaskComment;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TaskController extends Controller
{
    private TaskBoardColumnService $boarderColumnService;
    private TaskService $taskService;

    public function __construct()
    {
        $this->boarderColumnService = app(TaskBoardColumnService::class);
        $this->taskService = app(TaskService::class);
    }

    public function board()
    {
        $boardColumns = $this->boarderColumnService->filterTasks(request());

        return response()->success([
            'boarderColumns' => TaskBoardColumnResource::collection($boardColumns)
        ]);
    }

    public function update(StoreTask $request, $id){
        $this->taskService->update($request, $id);
        return response()->success();
    }

    public function show(Task $task)
    {
        $this->taskService->abortIfUserNotHaveTask(auth()->user(), $task);

        $task->load(["board_column", "create_by", "users"]);
        $first_5_history = $task->history()->with("board_column", "user")->take(5)->get();

        return response()->success([
            'task' => new TaskResource($task),
            'first_5_history' => TaskHistoryResource::collection($first_5_history)
        ]);
    }

    public function history(Task $task)
    {
        $history = $task->history()->with("user", 'board_column')->get();

        return response()->success([
            'activities' => TaskHistoryResource::collection($history)
        ]);
    }

    public function comments(Task $task)
    {
        $comments = $task->comments()->with("user")->get();

        return response()->success([
            'comments' => TaskHistoryResource::collection($comments)
        ]);
    }

    public function makeComment(Task $task)
    {
        request()->validate(['comment' => 'required']);
        TaskComment::create([
            'user_id' => auth()->id(),
            'comment' => request('comment'),
            'task_id' => $task->id,
        ]);

        return response()->success();
    }

    public function store(StoreTask $request)
    {
        $result = $this->taskService->store($request);

        return response()->success($result);
    }


    public function updateIndex(Task $task, Request $request)
    {
        $request->validate([
            'board_priority' => 'required|integer',
            'priority' => 'required|numeric',
        ]);

        $board_id = $request->board_id;
        $priority = $request->priority;

        $board = TaskboardColumn::orderBy('priority')->get()[request('board_priority')];
        $old_board = $task->board_column;

//        TaskJobMobileApp::dispatch($board, $old_board, $task, $priority);

        Task::where('board_column_id', $old_board->id)->where('column_priority', '>', $task->column_priority)->update(['column_priority' => DB::raw('column_priority - 1')]);
        $task->update([
            'board_column_id' => $board->id,
            'column_priority' => $priority,
            'completed_on' => $board->slug == 'completed' ? Carbon::now()->format('Y-m-d') : null,
        ]);
        Task::where('board_column_id', $board->id)->where('column_priority', '>=', $task->column_priority)->where('id', '!=', $task->id)->update(['column_priority' => DB::raw('column_priority + 1')]);


        return response()->success();
    }

    public function destroy(Task $task)
    {
        $this->taskService->abortIfUserNotHaveTask(auth()->user(), $task);
        $task->delete();
        return response()->success();
    }

}
