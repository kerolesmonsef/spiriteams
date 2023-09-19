<?php


namespace App\Http\Services;


use App\Helper\Files;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserService
{
    /**
     * @param Request $request
     * @return User
     * @throws \Exception
     */
    public function createOrUpdateBasedOnUuid(Request $request)
    {
        $uuid = $request->input('uuid');

        $user = User::findByUuid($uuid) ?? new User();
        $user->name = $request->input('name');
        $user->uuid = $uuid;
        $user->email = $request->input('email');
        $user->password ??= Hash::make($request->input('password'));
        $user->mobile = $request->input('mobile');
        $user->country_id = $request->input('phone_code');
        $user->gender = $request->input('gender');
        if ($request->has('login')) {
            $user->login = $request->login;
        }

        if ($request->has('email_notifications')) {
            $user->email_notifications = $request->email_notifications;
        }

        if ($request->hasFile('image')) {
            Files::deleteFile($user->image, 'avatar');
            $user->image = Files::upload($request->image, 'avatar', 300);
        }

        $user->save();

        cache()->forget('all-employees');
        cache()->forget('all-admins');

        return $user;
    }
}