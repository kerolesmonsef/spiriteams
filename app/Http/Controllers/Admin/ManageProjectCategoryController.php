<?php

namespace App\Http\Controllers\Admin;

use App\Helper\Reply;
use App\Http\Requests\Project\StoreProjectCategory;
use App\Http\Services\ProjectService;
use App\ProjectCategory;
use Illuminate\Http\Request;

class ManageProjectCategoryController extends AdminBaseController
{
    private ProjectService $projectService;

    public function __construct() {
        parent::__construct();
        $this->projectService = app(ProjectService::class);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {

    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $this->categories = ProjectCategory::all();
        return view('admin.project-category.create', $this->data);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function createCat()
    {
        $this->categories = ProjectCategory::all();
        return view('admin.projects.create-category', $this->data);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreProjectCategory $request)
    {
        $this->projectService->storeProjectCategory($request);

        return Reply::success(__('messages.categoryAdded'));
    }


    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function storeCat(StoreProjectCategory $request)
    {
        $category = new ProjectCategory();
        $category->category_name = $request->category_name;
        $category->save();
        $categoryData = ProjectCategory::all();
        $this->logUserActivity($this->user->id, __('messages.categoryAdded'));
        return Reply::successWithData(__('messages.categoryAdded'),['data' => $categoryData]);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {

    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        ProjectCategory::destroy($id);
        $this->logUserActivity($this->user->id, __('messages.categoryDeleted'));
        return Reply::success(__('messages.categoryDeleted'));
    }
}
