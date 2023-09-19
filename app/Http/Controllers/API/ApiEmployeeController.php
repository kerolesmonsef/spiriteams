<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\Employee\StoreEmployeeApi;
use App\Http\Requests\Admin\Employee\StoreRequest;
use App\Http\Resources\UserResource;
use App\Http\Services\EmployeeService;
use App\Http\Services\UserService;
use App\Role;
use App\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class ApiEmployeeController extends Controller
{
    /** @var UserService */
    private $userService;
    /** @var EmployeeService */
    private $employeeService;

    public function __construct()
    {
        $this->userService = app(UserService::class);
        $this->employeeService = app(EmployeeService::class);
    }

    public function index()
    {

        $employees = User::query();

        if (request('ids')) {
            $employees->whereIn('id', request('ids'));
        }

        if (request('name')) {
            $employees->where('name', "LIKE", "%" . request('name') . "%");
        }

        return response()->success([
            'users' => UserResource::collection($employees->get()),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     * @throws \Exception
     */
    public function store(StoreEmployeeApi $request)
    {
        try {
            DB::beginTransaction();
            $user = $this->userService->createOrUpdateBasedOnUuid($request);
            $employee = $this->employeeService->create($user, $request);

            $employeeRole = Role::where('name', 'employee')->first();
            $user->attachRole($employeeRole);
            DB::commit();
        } catch (\Exception $exception) {
            DB::rollBack();
            return response()->json([
                'status' => 'fail',
                'message' => $exception->getMessage(),
            ], 400);
        }


        return response()->json([
            "status" => "success"
        ]);
    }


    public function getEmployees( Request $request )
    {
        $employees = User::allEmployees()->when(  $request->filled('search') ,function($q){
            // dd(  request('search') );
            return $q->where('email','like','%'. 'ahme' .'%');
        });
        return response()->success(['employees' => $employees]);
    }
}
