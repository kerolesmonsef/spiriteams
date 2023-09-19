<?php

namespace App\Jobs;

use App\Task;
use App\TaskboardColumn;
use Carbon\Carbon;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use DB;

class TaskJobMobileApp implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    /**
     * Create a new job instance.
     *
     * @return void
     */

    private TaskboardColumn $board, $old_board;
    private Task $task;
    private int $priority;

    public function __construct(TaskboardColumn $board, TaskboardColumn $old_board, Task $task, int $priority)
    {
        $this->board        = $board;
        $this->old_board    = $old_board;
        $this->task         = $task;
        $this->priority     = $priority;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {

        $data = [
            'board_column_id'              => $this->board->id,
            'column_priority'              => $this->priority,
            'completed_on'                 => $this->board->slug == 'completed' ? Carbon::now()->format('Y-m-d')  :  null,
        ];

       Task::where('board_column_id',$this->old_board->id)->where('column_priority', '>', $this->task->column_priority)->update(['column_priority' => DB::raw('column_priority - 1')]);
        $this->task->update($data);
        Task::where('board_column_id',$this->board->id)->where('column_priority', '>=', $this->task->column_priority)->where('id','!=',$this->task->id)->update(['column_priority' => DB::raw('column_priority + 1')]);
    }
}
