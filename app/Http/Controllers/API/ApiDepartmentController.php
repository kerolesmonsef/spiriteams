<?php


namespace App\Http\Controllers\API;


use App\EmployeeDetails;
use App\Http\Controllers\Controller;
use App\Team;

class ApiDepartmentController extends Controller
{
    /**
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        return response()->json([
            'status' => 'success',
            'departments' => Team::all(),
        ]);
    }

    /**
     * @return \Illuminate\Http\JsonResponse
     */
    public function store()
    {
        request()->validate([
            'team_name' => ['required'],
            'id' => ['nullable'],
        ]);

        $team = Team::updateOrCreate([
            'id' => request('id'),
        ],[
            'team_name' => request('team_name'),
        ]);

        return response()->json([
            'status' => 'success',
            'department' => $team,
        ]);
    }



    /**
     * @param int $department
     * @return \Illuminate\Http\JsonResponse
     * @throws \Exception
     */
    public function destroy($id)
    {
        EmployeeDetails::where('department_id', $id)->update(['department_id' => NULL]);
        Team::destroy($id);

        return response()->json([
            'status' => 'success',
        ]);
    }
}