<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Requests\Project\StoreProjectCategory;
use App\Http\Services\ProjectService;
use App\ProjectCategory;
use Illuminate\Http\Request;

class ProjectCategoryController extends Controller
{
    private ProjectService $projectService;

    public function __construct()
    {
        $this->projectService = app(ProjectService::class);
    }

    public function index()
    {
        $categories = ProjectCategory::all();

        return response()->success([
            'categories' => $categories,
        ]);
    }

    public function store(StoreProjectCategory $request)
    {
        $this->projectService->storeProjectCategory($request);
        return response()->success();
    }


    public function destory(ProjectCategory $projectCategory)
    {
        $projectCategory->delete();
        $this->logUserActivity(user()->id, __('messages.categoryDeleted'));
        return response()->success();
    }
}
