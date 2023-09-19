<?php


namespace App\Http\Services;


use App\EmployeeDetails;
use App\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class EmployeeService
{
    private $global;

    public function __construct()
    {
        $this->global = getCachedSettings();
    }

    /**
     * @param User $user
     * @param Request $request
     * @return EmployeeDetails
     * @throws \Froiden\RestAPI\Exceptions\RelatedResourceNotFoundException
     */
    public function create($user, $request)
    {
        $employee_id = $request->employee_id;
        $max = EmployeeDetails::query()->max(DB::raw("CONVERT(employee_id, SIGNED INTEGER)")) ?? 0;

        if (!$employee_id) {
            $employee_id = $max + 1;
        }

        $employee = $user->employeeDetail ?? new EmployeeDetails();
        $employee->user_id = $user->id;
        $employee->employee_id = $user->employeeDetail ? $user->employeeDetail->employee_id : $employee_id;
        $employee->address = $request->address;
        $employee->hourly_rate = $request->hourly_rate;
        $employee->slack_username = $request->slack_username;
        $employee->department_id = $request->department;
        $employee->designation_id = $request->designation;


        $employee->joining_date = Carbon::createFromFormat($this->global->date_format, $request->joining_date ?? now()->format($this->global->date_format))->format('Y-m-d');
        if ($request->last_date != '') {
            $employee->last_date = Carbon::createFromFormat($this->global->date_format, $request->last_date)->format('Y-m-d');
        }
        $employee->save();

        return $employee;
    }
}