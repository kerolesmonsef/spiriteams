<?php

namespace App\Http\Middleware;

use App\Helper\JWTUtil;
use Closure;
use Exception;
use Illuminate\Support\Facades\Auth;

class JwtTokenLoginMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param \Illuminate\Http\Request $request
     * @param \Closure $next
     * @return mixed
     * @throws Exception
     */
    public function handle($request, Closure $next)
    {
        if ($request->wantsJson()) return $next($request); // for web only
        if (Auth::check()) return $next($request);

        $token = $request->header("token") ?? $request->get("token");

        if (!$token) { // it is used inside the web middleware
            return $next($request);
//            throw new Exception("Token Not found");
        }

        $user = JWTUtil::getUser($token);


        if (!$user) {
            throw new Exception("Invalid User Or Token Not Valid");
        }

        Auth::login($user);

        return redirect()->to("/");

    }
}
