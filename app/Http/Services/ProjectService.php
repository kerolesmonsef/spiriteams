<?php

namespace App\Http\Services;

use App\Helper\traits\LoggingTrait;
use App\Helper\traits\UniversalSearchTrait;
use App\Http\Requests\Project\StoreProject;
use App\Http\Requests\Project\StoreProjectCategory;
use App\Http\Requests\Project\UpdateProject;
use App\Project;
use App\ProjectCategory;
use App\ProjectMember;
use App\ProjectTemplate;
use App\SubTask;
use App\Task;
use App\TaskUser;
use App\Traits\ProjectProgress;
use Carbon\Carbon;

class ProjectService
{
    public function __construct()
    {
        $this->global = getCachedSettings();
    }

    use LoggingTrait, ProjectProgress, UniversalSearchTrait;

    public function store(StoreProject $request)
    {
        $project = new Project();
        $project->project_name = $request->project_name;
        if ($request->project_summary != '') {
            $project->project_summary = $request->project_summary;
        }
        $project->start_date = Carbon::createFromFormat($this->global->date_format, $request->start_date)->format('Y-m-d');

        if (!$request->has('without_deadline')) {
            $project->deadline = Carbon::createFromFormat($this->global->date_format, $request->deadline)->format('Y-m-d');
        }

        $project->notes = $request->notes;

        if ($request->category_id != '') {
            $project->category_id = $request->category_id;
        }
        $project->client_id = $request->client_id;

        if ($request->client_view_task) {
            $project->client_view_task = 'enable';
        } else {
            $project->client_view_task = "disable";
        }
        if (($request->client_view_task) && ($request->client_task_notification)) {
            $project->allow_client_notification = 'enable';
        } else {
            $project->allow_client_notification = "disable";
        }

        if ($request->manual_timelog) {
            $project->manual_timelog = 'enable';
        } else {
            $project->manual_timelog = "disable";
        }

        if ($request->team_id > 0) {
            $project->team_id = $request->team_id;
        }

        $project->project_budget = $request->project_budget;
        $project->currency_id = $request->currency_id;
        $project->hours_allocated = $request->hours_allocated;

        $project->status = $request->status ?? "in progress";

        $project->save();

        cache()->forget('all-projects');

        if ($request->template_id) {
            $template = ProjectTemplate::findOrFail($request->template_id);
            foreach ($template->members as $member) {
                $projectMember = new ProjectMember();

                $projectMember->user_id = $member->user_id;
                $projectMember->project_id = $project->id;
                $projectMember->save();

            }
            foreach ($template->tasks as $task) {
                $projectTask = new Task();

                $projectTask->project_id = $project->id;
                $projectTask->heading = $task->heading;
                $projectTask->task_category_id = $task->project_template_task_category_id;
                $projectTask->description = $task->description;
                $projectTask->due_date = Carbon::now()->addDay()->format('Y-m-d');
                $projectTask->status = 'incomplete';
                $projectTask->save();

                foreach ($task->users_many as $key => $value) {
                    TaskUser::create(
                        [
                            'user_id' => $value->id,
                            'task_id' => $projectTask->id
                        ]
                    );
                }

                foreach ($task->subtasks as $key => $value) {
                    SubTask::create(
                        [
                            'title' => $value->title,
                            'task_id' => $projectTask->id
                        ]
                    );
                }
            }
        }

        // To add custom fields data
        if ($request->get('custom_fields_data')) {
            $project->updateCustomFieldData($request->get('custom_fields_data'));
        }

        $users = $request->user_id;

        foreach ($users as $user) {
            $member = new ProjectMember();
            $member->user_id = $user;
            $member->project_id = $project->id;
            $member->save();

            $this->logProjectActivity($project->id, ucwords($member->user->name) . ' ' . __('messages.isAddedAsProjectMember'));
        }

        $this->logSearchEntry($project->id, 'Project: ' . $project->project_name, 'admin.projects.show', 'project');

        $this->logProjectActivity($project->id, ucwords($project->project_name) . ' ' . __("messages.addedAsNewProject"));

        $this->logUserActivity(user()->id, __('messages.addedAsNewProject'));

        return $project;
    }

    public function update(UpdateProject $request, $id)
    {
        $project = Project::findOrFail($id);
        $project->project_name = $request->project_name;
        if ($request->project_summary != '') {
            $project->project_summary = $request->project_summary;
        }
        $project->start_date = Carbon::createFromFormat($this->global->date_format, $request->start_date)->format('Y-m-d');
        if (!$request->has('without_deadline')) {
            $project->deadline = Carbon::createFromFormat($this->global->date_format, $request->deadline)->format('Y-m-d');
        } else {
            $project->deadline = null;
        }
        if ($request->notes != '') {
            $project->notes = $request->notes;
        }
        if ($request->category_id != '') {
            $project->category_id = $request->category_id;
        }

        if ($request->client_view_task) {
            $project->client_view_task = 'enable';
        } else {
            $project->client_view_task = "disable";
        }
        if (($request->client_view_task) && ($request->client_task_notification)) {
            $project->allow_client_notification = 'enable';
        } else {
            $project->allow_client_notification = "disable";
        }

        if ($request->manual_timelog) {
            $project->manual_timelog = 'enable';
        } else {
            $project->manual_timelog = "disable";
        }

        $project->team_id = null;
        if ($request->team_id > 0) {
            $project->team_id = $request->team_id;
        }

        $project->client_id = ($request->client_id == 'null' || $request->client_id == '') ? null : $request->client_id;
        $project->feedback = $request->feedback;

        if ($request->calculate_task_progress) {
            $project->calculate_task_progress = $request->calculate_task_progress;
            $project->completion_percent = $this->calculateProjectProgress($id);
        } else {
            $project->calculate_task_progress = "false";
            $project->completion_percent = $request->completion_percent;
        }

        $project->project_budget = $request->project_budget;
        $project->currency_id = $request->currency_id;
        $project->hours_allocated = $request->hours_allocated;
        $project->status = $request->status;

        $project->save();

        // To add custom fields data
        if ($request->get('custom_fields_data')) {
            $project->updateCustomFieldData($request->get('custom_fields_data'));
        }

        $this->logProjectActivity($project->id, ucwords($project->project_name) . __('modules.projects.projectUpdated'));
        $this->logUserActivity(user()->id, __('messages.projectUpdated'));

        return $project;
    }

    public function storeProjectCategory(StoreProjectCategory $request)
    {
        $category = new ProjectCategory();
        $category->category_name = $request->category_name;
        $category->save();

        $this->logUserActivity($this->user->id, __('messages.categoryAdded'));

        return $category;
    }
}