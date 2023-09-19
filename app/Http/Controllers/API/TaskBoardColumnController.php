<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Requests\TaskBoard\StoreTaskBoard;
use App\Http\Requests\TaskBoard\UpdateTaskBoard;
use App\Http\Resources\TaskBoardColumnResource;
use App\Services\TaskBoardColumnService;
use App\TaskboardColumn;
use Illuminate\Http\Request;

class TaskBoardColumnController extends Controller
{
    private TaskBoardColumnService $taskBoardColumnService;

    public function __construct()
    {
        $this->middleware("permission:view_column_task")->only("index");
        $this->middleware("permission:edit_column_task")->only("update");
        $this->middleware("permission:add_column_task")->only("store");
        $this->middleware("permission:delete_column_task")->only("destroy");

        $this->taskBoardColumnService = app(TaskBoardColumnService::class);
    }

    public function index()
    {
        $boardColumns = TaskboardColumn::query()->orderBy("priority")->get();

        return response()->success([
            'boarderColumns' => TaskBoardColumnResource::collection($boardColumns),
        ]);
    }

    public function store(StoreTaskBoard $request)
    {
        $board = $this->taskBoardColumnService->store($request);

        return response()->success([
            'board'=> new TaskBoardColumnResource($board)
        ]);
    }

    public function update(UpdateTaskBoard $taskBoardRequest, $id)
    {
        $this->taskBoardColumnService->update($taskBoardRequest, $id);

        return response()->success();
    }

    public function destroy($id)
    {
        $this->taskBoardColumnService->destroy($id);

        return response()->success();
    }
}
