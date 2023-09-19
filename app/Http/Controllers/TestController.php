<?php

namespace App\Http\Controllers;

use App\Helper\JWTUtil;
use App\Http\Services\EmployeeService;
use App\Http\Services\UserService;
use App\Role;
use App\Task;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TestController extends Controller
{
    /**
     * @var UserService
     */
    private $userService;
    /**
     * @var EmployeeService
     */
    private $employeeService;

    public function __construct()
    {
        $this->userService = app(UserService::class);
        $this->employeeService = app(EmployeeService::class);

    }

    public function test()
    {

        dd(JWTUtil::encode([
            'uuid' => User::first()->uuid,
        ]));

    }
}
