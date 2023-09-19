<?php

namespace App\Jobs;

use App\Task;
use Carbon\Carbon;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class TaskJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    private $board, $boardColumnIds, $priorities, $taskIds;
    public function __construct($board, $boardColumnIds, $priorities, $taskIds)
    {
        $this->board = $board;
        $this->boardColumnIds = $boardColumnIds;
        $this->priorities = $priorities;
        $this->taskIds = $taskIds;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        if (isset($this->taskIds) && count($this->taskIds) > 0) {

            $this->taskIds = (array_filter($this->taskIds, function ($value) {
                return $value !== null;
            }));

            foreach ($this->taskIds as $key => $taskId) {
                if (!is_null($taskId)) {
                    $task = Task::findOrFail($taskId);
                    if ($this->board->slug == 'completed') {
                        $task->update(
                            [
                                'board_column_id' => $this->boardColumnIds[$key],
                                'completed_on' => Carbon::now()->format('Y-m-d'),
                                'column_priority' => $this->priorities[$key]
                            ]
                        );
                    } else {
                        $task->update(
                            [
                                'board_column_id' => $this->boardColumnIds[$key],
                                'column_priority' => $this->priorities[$key]
                            ]
                        );
                    }
                }
            }

            // if ($request->draggingTaskId == 0 && $request->draggedTaskId != 0) {
            // $this->logTaskActivity($request->draggedTaskId, $this->user->id, "statusActivity", $board->id);
            // $updatedTask = Task::findOrFail($request->draggedTaskId);
            // event(new TaskUpdated($updatedTask));
            // }
            // $this->triggerPusher('task-updated-channel', 'task-updated', ['user_id' => $this->user->id, 'task_id' => $request->draggingTaskId]);
        }
    }
}
