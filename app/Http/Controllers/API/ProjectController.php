<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Requests\Project\StoreProject;
use App\Http\Requests\Project\UpdateProject;
use App\Http\Resources\TaskBoardColumnResource;
use App\Http\Resources\ProjectResource;
use App\Http\Services\ProjectService;
use App\Project;
use App\TaskboardColumn;
use App\User;

class ProjectController extends Controller
{
    private ProjectService $projectService;

    public function __construct()
    {
        $this->middleware("permission:add_projects")->only("store");
        $this->middleware("permission:view_projects")->only("index");
        $this->middleware("permission:delete_projects")->only("destroy");
        $this->middleware("permission:add_projects")->only("store");
        $this->projectService = app(ProjectService::class);
    }


    /**
     * @throws \Exception
     */
    public function index()
    {

        /** @var User $user */
        $user = auth()->user();

        if ($user->hasRole('admin')) {
            $projects = Project::allProjects()->load(["category",'members_many']);
        } else {
            $projects = $user->my_projects->load('members_many');
        }

        return response()->success([
            'projects'  => ProjectResource::collection($projects),
            'filters'   => [
                'status'            => [
                    'not started'    => trans('app.notStarted') ,
                    'in progress'    => trans('app.inProgress') ,
                    'on hold'        => trans('app.onHold'),
                    'canceled'       => trans('app.canceled'),
                    'finished'       => trans('app.finished'),
                    'under review'   => trans('app.underReview'),
                ],
            ] 
        ]);
    }

    public function store(StoreProject $request)
    {
        $project = $this->projectService->store($request);

        return response()->success([
            'project' => new ProjectResource($project),
        ]);
    }

    public function update(UpdateProject $request, $id)
    {
        $this->projectService->update($request, $id);

        return response()->success();
    }

    public function show(Project $project)
    {

        return response()->success([
            'project' => new ProjectResource($project),
        ]);
    }


    /**
     * @throws \Exception
     */
    public function destroy(Project $project)
    {
        $project->delete();

        return response()->success();
    }
}