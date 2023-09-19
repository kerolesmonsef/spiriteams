<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Contracts\Auth\Guard;
use Illuminate\Support\Facades\Config;
use Trebol\Entrust\Middleware\EntrustPermission;

class CustomEntrustPermissionMiddleware extends EntrustPermission
{
    public function __construct(Guard $auth)
    {
        parent::__construct($auth);
    }

    public function handle($request, Closure $next, $permissions)
    {
        if (!is_array($permissions)) {
            $permissions = explode(self::DELIMITER, $permissions);
        }
        if ( !$this->auth->guest() && $this->auth->user()->hasRole('admin'))         return $next($request);

        if ($this->auth->guest() || !$request->user()->cans($permissions)) {
            if ($request->acceptsJson()) {
                return response()->json([
                    'message'=> "you don't have permission to enter this route"
                ], 403);
            } else {
                abort(403);
            }
        }

        return $next($request);
    }
}