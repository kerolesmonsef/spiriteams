<?php


namespace App\Http\Services;


use App\Role;
use App\RoleUser;

class RoleService
{
    /**
     * @param $request
     * @throws \Froiden\RestAPI\Exceptions\RelatedResourceNotFoundException
     */
    public function assignRole($request){
        $employeeRole = Role::where('name', 'employee')->first();
        foreach ($request->user_id as $user) {
            RoleUser::where('user_id', $user)->delete();

            $roleUser = new RoleUser();
            $roleUser->user_id = $user;
            $roleUser->role_id = $employeeRole->id;
            $roleUser->save();

            $roleUser = new RoleUser();
            $roleUser->user_id = $user;
            $roleUser->role_id = $request->role_id;
            $roleUser->save();
        }
    }
}