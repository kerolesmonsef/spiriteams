<?php

namespace App\Services;

use App\Helper\Files;
use App\Helper\Reply;
use App\Helper\traits\LoggingTrait;
use App\Helper\traits\UniversalSearchTrait;
use App\Http\Requests\Tasks\StoreTask;
use App\Task;
use App\TaskboardColumn;
use App\TaskFile;
use App\TaskUser;
use App\Traits\ProjectProgress;
use App\User;
use Carbon\Carbon;

class TaskService
{
    use UniversalSearchTrait, ProjectProgress, LoggingTrait;

    private $global;

    public function __construct()
    {
        $this->global = getCachedSettings();
    }

    public function abortIfUserNotHaveTask(User $user, Task $task)
    {
        if ($user->hasRole("admin")) return;
        if ($task->getAttribute('created_by') == $user->id) return;
        $userAssignedTask = $task->users()->where("task_users.user_id", $user->id)->exists();

        abort_if(!$userAssignedTask, "403", "you don't have permission to access this task");
    }

    public function store(StoreTask $request)
    {
        $task = new Task();
        $task->heading = $request->heading;
        if ($request->description != '') {
            $task->description = $request->description;
        }
        $task->start_date = Carbon::createFromFormat($this->global->date_format, $request->start_date)->format('Y-m-d');
        $task->due_date = Carbon::createFromFormat($this->global->date_format, $request->due_date)->format('Y-m-d');
        $task->project_id = $request->project_id;
        $task->priority = $request->priority;
        $task->board_column_id = $this->global->default_task_status;
        $task->task_category_id = $request->category_id;
        $task->dependent_task_id = $request->has('dependent') && $request->dependent == 'yes' && $request->has('dependent_task_id') && $request->dependent_task_id != '' ? $request->dependent_task_id : null;
        $task->is_private = $request->has('is_private') && $request->is_private == 'true' ? 1 : 0;
        $task->billable = $request->has('billable') && $request->billable == 'true' ? 1 : 0;
        $task->estimate_hours = $request->estimate_hours ?? 0;
        $task->estimate_minutes = $request->estimate_minutes ?? 0;

        if ($request->board_column_id) {
            $task->board_column_id = $request->board_column_id;
        }

        $task->save();

        // save labels
        $task->labels()->sync($request->task_labels);

        if (!user()->can('add_tasks') && $this->global->task_self == 'yes') {
            $request->user_id = [user()->id];
        }

        // For gantt chart
        if ($request->page_name && $request->page_name == 'ganttChart') {
            $parentGanttId = $request->parent_gantt_id;

            $taskDuration = $task->due_date->diffInDays($task->start_date);
            $taskDuration = $taskDuration + 1;

            $ganttTaskArray[] = [
                'id' => $task->id,
                'text' => $task->heading,
                'start_date' => $task->start_date->format('Y-m-d'),
                'duration' => $taskDuration,
                'parent' => $parentGanttId,
                'taskid' => $task->id
            ];

            $gantTaskLinkArray[] = [
                'id' => 'link_' . $task->id,
                'source' => $task->dependent_task_id != '' ? $task->dependent_task_id : $parentGanttId,
                'target' => $task->id,
                'type' => $task->dependent_task_id != '' ? 0 : 1
            ];
        }

        // Add repeated task
        if ($request->has('repeat') && $request->repeat == 'yes') {
            $repeatCount = $request->repeat_count;
            $repeatType = $request->repeat_type;
            $repeatCycles = $request->repeat_cycles;
            $startDate = Carbon::createFromFormat($this->global->date_format, $request->start_date)->format('Y-m-d');
            $dueDate = Carbon::createFromFormat($this->global->date_format, $request->due_date)->format('Y-m-d');


            for ($i = 1; $i < $repeatCycles; $i++) {
                $repeatStartDate = Carbon::createFromFormat('Y-m-d', $startDate);
                $repeatDueDate = Carbon::createFromFormat('Y-m-d', $dueDate);

                if ($repeatType == 'day') {
                    $repeatStartDate = $repeatStartDate->addDays($repeatCount);
                    $repeatDueDate = $repeatDueDate->addDays($repeatCount);
                } else if ($repeatType == 'week') {
                    $repeatStartDate = $repeatStartDate->addWeeks($repeatCount);
                    $repeatDueDate = $repeatDueDate->addWeeks($repeatCount);
                } else if ($repeatType == 'month') {
                    $repeatStartDate = $repeatStartDate->addMonths($repeatCount);
                    $repeatDueDate = $repeatDueDate->addMonths($repeatCount);
                } else if ($repeatType == 'year') {
                    $repeatStartDate = $repeatStartDate->addYears($repeatCount);
                    $repeatDueDate = $repeatDueDate->addYears($repeatCount);
                }


                $newTask = new Task();
                $newTask->heading = $request->heading;
                if ($request->description != '') {
                    $newTask->description = $request->description;
                }
                $newTask->start_date = $repeatStartDate->format('Y-m-d');
                $newTask->due_date = $repeatDueDate->format('Y-m-d');
                $newTask->project_id = $request->project_id;
                $newTask->priority = $request->priority;
                $newTask->task_category_id = $request->category_id;
                $newTask->recurring_task_id = $task->id;

                if ($request->board_column_id) {
                    $newTask->board_column_id = $request->board_column_id;
                }

                $newTask->estimate_hours = $request->estimate_hours;
                $newTask->estimate_minutes = $request->estimate_minutes;
                $newTask->is_private = $request->has('is_private') && $request->is_private == 'true' ? 1 : 0;
                $newTask->billable = $request->has('billable') && $request->billable == 'true' ? 1 : 0;


                $newTask->save();
                $newTask->labels()->sync($request->task_labels);

                if (!user()->can('add_tasks') && $this->global->task_self == 'yes') {
                    $request->user_id = [user()->id];
                }

                foreach ($request->user_id as $key => $value) {
                    TaskUser::create(
                        [
                            'user_id' => $value,
                            'task_id' => $newTask->id
                        ]
                    );
                }



                // For gantt chart
                if ($request->page_name && $request->page_name == 'ganttChart') {
                    $parentGanttId = $request->parent_gantt_id;
                    $taskDuration = $newTask->due_date->diffInDays($newTask->start_date);
                    $taskDuration = $taskDuration + 1;

                    $ganttTaskArray[] = [
                        'id' => $newTask->id,
                        'text' => $newTask->heading,
                        'start_date' => $newTask->start_date->format('Y-m-d'),
                        'duration' => $taskDuration,
                        'parent' => $parentGanttId,
                        'taskid' => $newTask->id
                    ];

                    $gantTaskLinkArray[] = [
                        'id' => 'link_' . $newTask->id,
                        'source' => $parentGanttId,
                        'target' => $newTask->id,
                        'type' => 1
                    ];
                }

                $startDate = $newTask->start_date->format('Y-m-d');
                $dueDate = $newTask->due_date->format('Y-m-d');
            }
        }

        if ($request->project_id) {
            $this->calculateProjectProgress($request->project_id);
        }

        //log search
        $this->logSearchEntry($task->id, 'Task ' . $task->heading, 'admin.all-tasks.edit', 'task');

        if ($request->page_name && $request->page_name == 'ganttChart') {

            return Reply::successWithData(
                'messages.taskCreatedSuccessfully',
                [
                    'tasks' => $ganttTaskArray,
                    'links' => $gantTaskLinkArray
                ]
            );
        }
        //upload_file
        if (isset($request->upload_file)) {
            foreach ($request->upload_file as $fileData) {
                $storage = config('filesystems.default');
                $file = new TaskFile();
                $file->user_id = user()->id;
                $file->task_id = $task->id;
                $filename = Files::uploadLocalOrS3($fileData, 'task-files/' . $task->id);
                $file->filename = $fileData->getClientOriginalName();
                $file->hashname = $filename;
                $file->size = $fileData->getSize();
                $file->save();
            }
        }

        if ($request->board_column_id and !$request->wantsJson()) {
            return Reply::redirect(route('member.taskboard.index'), __('messages.taskCreatedSuccessfully'));
        }

        return Reply::dataOnly(['taskID' => $task->id]);
    }

    public function update(StoreTask $request, $id)
    {

        $task = Task::findOrFail($id);

        $task->heading = $request->heading;
        if ($request->description != '') {
            $task->description = $request->description;
        }
        $task->start_date = Carbon::createFromFormat($this->global->date_format, $request->start_date)->format('Y-m-d');
        $task->due_date = Carbon::createFromFormat($this->global->date_format, $request->due_date)->format('Y-m-d');
        $task->priority = $request->priority;
        $task->task_category_id = $request->category_id;
        $task->board_column_id = $request->status ?? $request->board_column_id;
        $task->dependent_task_id = $request->has('dependent') && $request->dependent == 'yes' && $request->has('dependent_task_id') && $request->dependent_task_id != '' ? $request->dependent_task_id : null;
        $task->is_private = $request->has('is_private') && $request->is_private == 'true' ? 1 : 0;
        $task->billable = $request->has('billable') && $request->billable == 'true' ? 1 : 0;
        $task->estimate_hours = $request->estimate_hours;
        $task->estimate_minutes = $request->estimate_minutes;

        $taskBoardColumn = TaskboardColumn::findOrFail($request->status ?? $request->board_column_id);

        if ($taskBoardColumn->slug == 'completed') {
            $task->completed_on = Carbon::now();
        } else {
            $task->completed_on = null;
        }

        if ($request->milestone_id != '') {
            $task->milestone_id = $request->milestone_id;
        }

        $task->save();

        // Sync task users
        $task->users()->sync($request->user_id);

        //calculate project progress if enabled
        $this->calculateProjectProgress($request->project_id);


        $this->logUserActivity(user()->id, __('messages.taskUpdatedSuccessfully'));

        return $task;
    }
}