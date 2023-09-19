<?php

namespace App\Events;

use App\Task;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;



class TaskEvent implements ShouldQueue
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $task;
    public $notifyUser;
    public $notificationName;

    public function __construct(Task $task, $notifyUser, $notificationName)
    {
        $this->task = $task;
        $this->notifyUser = $notifyUser;
        $this->notificationName = $notificationName;
    }

}
