<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Http\Resources\UserResource;
use Illuminate\Http\Request;

class AuthController extends Controller
{
    public function me()
    {
        return response()->success([
            'user' => new UserResource(auth()->user()),
        ]);
    }

    public function toggleEmailNotification(Request $request)
    {
        $request->validate([
            'email_notifications'       => 'required|numeric|in:1,0',
        ]);
        auth()->user()->update(['email_notifications'   =>  $request->email_notifications ]);

        return response()->success([
            'user' => new UserResource(auth()->user()),
        ]);
    }
}
