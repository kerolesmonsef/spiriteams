<?php

namespace App\Http\Controllers\Admin;

use App\Designation;
use App\EmployeeDetails;
use App\Helper\Reply;
use App\Http\Requests\Designation\DesignationStoreRequest;
use App\Http\Requests\Designation\DesignationUpdateRequest;
use App\Http\Services\DesignationService;

class ManageDesignationController extends AdminBaseController
{
    private DesignationService $designationService;

    public function __construct()
    {
        parent::__construct();
        $this->pageTitle = 'app.menu.designation';
        $this->pageIcon = 'icon-user';
        $this->middleware(function ($request, $next) {
            if (!in_array('employees', $this->user->modules)) {
                abort(403);
            }
            return $next($request);
        });

        $this->designationService = app(DesignationService::class);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $this->groups = Designation::with('members', 'members.user')->get();
        return view('admin.designation.index', $this->data);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('admin.designation.create', $this->data);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function quickCreate()
    {
        $this->teams = Designation::all();
        return view('admin.designation.quick-create', $this->data);
    }

    /**
     * @param DesignationStoreRequest $request
     * @return array
     */
    public function store(DesignationStoreRequest $request)
    {
        $this->designationService->store($request);

        return Reply::redirect(route('admin.designations.index'), __('messages.designationAdded'));
    }

    /**
     * @param DesignationStoreRequest $request
     * @return array
     */
    public function quickStore(DesignationStoreRequest $request)
    {
        $group = $this->designationService->store($request);

        $designations = Designation::all();
        $teamData = '';

        foreach ($designations as $team) {
            $selected = '';

            if ($team->id == $group->id) {
                $selected = 'selected';
            }

            $teamData .= '<option ' . $selected . ' value="' . $team->id . '"> ' . $team->name . ' </option>';
        }


        return Reply::successWithData(__('messages.designationAdded'), ['designationData' => $teamData]);
    }

    /**
     * Display the specified resource.
     *[
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $this->designation = Designation::with('members', 'members.user')->findOrFail($id);
        return view('admin.designation.edit', $this->data);
    }

    /**
     * @param DesignationUpdateRequest $request
     * @param $id
     * @return array
     */
    public function update(DesignationUpdateRequest $request, $id)
    {
        $this->designationService->update($request, $id);

        return Reply::redirect(route('admin.designations.index'), __('messages.updatedSuccessfully'));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        EmployeeDetails::where('designation_id', $id)->update(['designation_id' => NULL]);
        Designation::destroy($id);
        return Reply::dataOnly(['status' => 'success']);
    }
}
