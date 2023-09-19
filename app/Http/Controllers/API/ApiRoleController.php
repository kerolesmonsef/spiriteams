<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Requests\Role\StoreUserRole;
use App\Http\Services\RoleService;
use App\Role;
use App\User;
use Illuminate\Http\Request;

class ApiRoleController extends Controller
{
    private $roleService;

    public function __construct()
    {
        $this->roleService = app(RoleService::class);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        $roles = Role::get();

        return response()->json([
            'roles' => $roles,
        ]);
    }


    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {

        request()->validate([
            'name'              => ['unique:roles,name'],
        ]);

        $role = Role::query()->create([
            'name' => request('name'),
            'display_name' => ucwords(request('name')),
        ]);
        $role->attachPermissions($request->permissions);

        return response()->json();
    }

    public function detachRole(User $user)
    {
        request()->validate([
            'role_id' => 'required',
        ]);

        $user->detachRole(request('role_id'));

        return response()->json();
    }

    public function assignRole(StoreUserRole $request)
    {
        $this->roleService->assignRole($request);
        return response()->json();
    }

    /**
     * Display the specified resource.
     *
     * @param Role $role
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(Role $role)
    {
        $role->load("p_permissions");

        return response()->json([
            'role' => $role,
        ]);
    }


    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param Role $role
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Role $role,Request $request)
    {
        request()->validate([
            'name' => ['required','unique:roles,name,'.$role['id']]
        ]);
        $role->update([
            'display_name' => request('name'),
        ]);
        $role->savePermissions( request('permissions') );

        return response()->json();
    }



    /**
     * Remove the specified resource from storage.
     *
     * @param Role $role
     * @return \Illuminate\Http\JsonResponse
     * @throws \Exception
     */
    public function destroy(Role $role)
    {
        abort_if($role->id <= 3, 400, "you can't delete this role");

        $role->delete();

        return response()->json();
    }
}
