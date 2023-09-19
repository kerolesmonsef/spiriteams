<?php

namespace App\Services;

use App\Helper\Reply;
use App\Helper\traits\LoggingTrait;
use App\Http\Requests\TaskBoard\StoreTaskBoard;
use App\Http\Requests\TaskBoard\UpdateTaskBoard;
use App\Task;
use App\TaskboardColumn;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;

class TaskBoardColumnService
{
    use LoggingTrait;

    public function filterTasks(Request $request)
    {
        $boardColumnQuery = TaskboardColumn::query();

        if (request('column_id')) {
            $boardColumnQuery->where('id', request('column_id'));
        }

        $boardColumnQuery->orderBy("priority");

        $boardColumns = $boardColumnQuery->get();

        foreach ($boardColumns as $boardColumn) {
            if (auth()->user()->hasRole("admin")) {
                $tasks_i_query = $boardColumn->tasks();
            } else {
                $tasks_i_query = Task::where(function (Builder $query) {
                    $query->where("created_by", auth()->id())
                        ->orWhereHas("users", function (Builder $query) {
                            $query->where("task_users.user_id", auth()->id());
                        });
                });
            }

            if (request('project_id')) {
                $tasks_i_query->where("tasks.project_id", request('project_id'));
            }

            $tasks_i_query
                ->orderBy("column_priority")
                ->with(["users",'files']);

            $boardColumn->task_paginated = $tasks_i_query->get();
        }

        return $boardColumns;
    }

    public function store(StoreTaskBoard $request)
    {
        $maxPriority = TaskboardColumn::max('priority');

        $board = new TaskboardColumn();
        $board->column_name = $request->column_name;
        $board->label_color = $request->label_color;
        $board->slug = str_slug($request->column_name, '_');
        $board->priority = $request->priority ?? ($maxPriority + 1);
        $board->save();
        $this->logUserActivity(user()->id, __('messages.boardColumnSaved'));

        return $board;
    }


    public function update(UpdateTaskBoard $request, $id)
    {
        $board = TaskboardColumn::findOrFail($id);
        $oldPosition = $board->priority;
        $newPosition = $request->priority ?? $board->priority;

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
        $this->logUserActivity(user()->id, __('messages.boardColumnSaved'));
        return $board;
    }


    public function destroy($id)
    {
        Task::where('board_column_id', $id)->update(['board_column_id' => 1]);

        $board = TaskboardColumn::findOrFail($id);

        $boardColumn = TaskboardColumn::where('slug', 'incomplete')->first();

        Task::where('board_column_id', $board->id)->update(['board_column_id' => $boardColumn->id]);

        $otherColumns = TaskboardColumn::where('priority', '>', $board->priority)
            ->orderBy('priority', 'asc')
            ->get();

        foreach ($otherColumns as $column) {
            $pos = TaskboardColumn::where('priority', $column->priority)->first();
            $pos->priority = ($pos->priority - 1);
            $pos->save();
        }

        TaskboardColumn::destroy($id);
        $this->logUserActivity(user()->id, __('messages.boardColumnDeleted'));
    }
}