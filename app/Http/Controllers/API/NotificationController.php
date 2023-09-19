<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;

class NotificationController extends Controller
{
    public function index()
    {
        return response()->success([
            'notifications' => auth()->user()->notifications()->simplePaginate()
        ]);
    }
}