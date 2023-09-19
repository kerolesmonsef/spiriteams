<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Permission;
use App\Role;
use App\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Collection;

class PermissionController extends Controller
{
    /**
     * Handle the incoming request.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $permissions = Permission::with('module')->get()->groupBY('module.module_name');
        return response()->success([
            'permissions' => $permissions,
        ]);
    }

    public function userPermissions(): JsonResponse
    {
        $allPermissions = Permission::all();
        /** @var User $user */
        $user = auth()->user();
        /** @var Permission[]|Collection $userPermissions */
        $userPermissions = $user->p_permissions();


        $allPermissions = $allPermissions->map(function (Permission $permission) use ($userPermissions, $user) {
            return [
                'name' => $permission->name,
                'hasAccess' => $user->hasRole("admin") || ($userPermissions->where("name", $permission->name)->first() != null),
            ];
        });

        return response()->success([
            'permissions' => $allPermissions->pluck('hasAccess', 'name')->toArray(),
        ]);
    }
}
