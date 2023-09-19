<?php

namespace App\Helper\traits;

use App\ProjectActivity;
use App\TaskHistory;
use App\UserActivity;
use Pusher\Pusher;

trait LoggingTrait
{
    public function logUserActivity($userId, $text)
    {
        $activity = new UserActivity();
        $activity->user_id = $userId;
        $activity->activity = $text;
        $activity->save();
    }

    public function logTaskActivity($taskID, $userID, $text, $boardColumnId, $subTaskId = null)
    {
        $activity = new TaskHistory();
        $activity->task_id = $taskID;

        if (!is_null($subTaskId)) {
            $activity->sub_task_id = $subTaskId;
        }

        $activity->user_id = $userID;
        $activity->details = $text;
        $activity->board_column_id = $boardColumnId;
        $activity->save();
    }

    public function triggerPusher($channel, $event, $data)
    {
        if (pusher_settings()->status) {
            $pusher = new Pusher(pusher_settings()->pusher_app_key, pusher_settings()->pusher_app_secret, pusher_settings()->pusher_app_id, array('cluster' => pusher_settings()->pusher_cluster, 'useTLS' => pusher_settings()->force_tls));
            $pusher->trigger($channel, $event, $data);
        }
    }

    public function logProjectActivity($projectId, $text)
    {
        $activity = new ProjectActivity();
        $activity->project_id = $projectId;
        $activity->activity = $text;
        $activity->save();
    }

}