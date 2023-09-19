<?php

namespace App\Http\Controllers\API;

use App\Designation;
use App\EmployeeDetails;
use App\Http\Controllers\Controller;
use App\Http\Requests\Designation\DesignationStoreRequest;
use App\Http\Requests\Designation\DesignationUpdateRequest;
use App\Http\Services\DesignationService;

class ApiDesignationController extends Controller
{
    private DesignationService $designationService;

    public function __construct()
    {
        $this->designationService = app(DesignationService::class);
    }

    public function store(DesignationStoreRequest $request)
    {
        $designation = $this->designationService->store($request);

        return response()->success([
            'designation' => $designation,
        ]);
    }

    public function destroy($id)
    {
        EmployeeDetails::where('designation_id', $id)->update(['designation_id' => NULL]);
        Designation::destroy($id);

        return response()->success();
    }
}