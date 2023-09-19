<?php

namespace App\Http\Controllers\ApI;

use App\Http\Controllers\Controller;
use App\Http\Resources\ProjectResource;
use App\Http\Resources\TaskBoardColumnResource;
use App\Http\Resources\TaskResource;
use App\Project;
use App\Task;
use App\Traits\ApiResponser;
use App\User;
use Illuminate\Http\Request;
use App\Lead;
use App\TaskboardColumn;
use Carbon\carbon;

/**
 * Class ProfileController
 * @package App\Http\Controllers\Api\V1\Employee
 */
class HomeController extends Controller
{
    use ApiResponser;

    public function index(Request $request)
    {

        $lead = new Lead();
        $lead->company_name = $request->company_name;
        $lead->client_name = $request->name;
        $lead->client_email = $request->email;
        $lead->phone = $request->phone;
        $lead->form_lang = $request->form_lang;
        $lead->note = $request->note;
        $lead->agent_id = 17;
        $lead->card_no = rand(10, 100000000);
        $lead->save();

        // To add custom fields data
        if ($request->get('custom_fields_data')) {
            $lead->updateCustomFieldData($request->get('custom_fields_data'));
        }

        //$this->logEntryLead($lead);
        return $this->success([], __('messages.LeadAddedUpdated'));
    }

    public function mobileHome(Request $request)
    {

        /** @var User $user */
        $user = auth()->user();

        if ($user->hasRole("admin")) {
            $projects = Project::allProjects()->load('members_many')->filter(function ($project) {
                return str_contains( strtolower($project->project_name), strtolower(request('search')));
            });
            $tasks = Task::query()->when($request->filled('search'), function ($q) {
                return $q->where('heading', 'like', '%' . request('search')  . '%');
            })->latest();
        } else {
            $projects = $user->my_projects->load('members_many')->filter(function ($project) {
                return str_contains( strtolower($project->project_name), strtolower(request('search')));
            });
            $tasks = $user->tasks()->when($request->filled('search'), function ($q) {
                return $q->where('heading', 'like', '%' . request('search')  . '%');
            })->latest();
        }

        $tasks = $tasks->take(10)->get();

        $boards = TaskboardColumn::orderBy('priority')->get();

        $projects->load("category");
        $tasks->load(["users", 'board_column', 'files']);

        return response()->success([
            "tasks" => TaskResource::collection($tasks),
            "projects" => ProjectResource::collection($projects),
            'boards'   => TaskBoardColumnResource::collection($boards)
        ]);
    }
}
