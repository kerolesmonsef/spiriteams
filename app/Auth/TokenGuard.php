<?php


namespace App\Auth;


use App\Helper\JWTUtil;
use App\User;
use Exception;
use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Contracts\Auth\Guard;
use Illuminate\Http\Request;

class TokenGuard implements Guard
{

    /**
     * @var Request
     */
    private $request;

    /**
     * TokenGuard constructor.
     * @param Request $request
     */
    public function __construct(Request $request)
    {
        $this->request = $request;
    }

    /**
     * Determine if the current user is authenticated.
     *
     * @return bool
     */
    public function check()
    {
        return $this->user();
    }

    /**
     * Determine if the current user is a guest.
     *
     * @return bool
     */
    public function guest()
    {
        return !$this->check();
    }

    /**
     * Get the currently authenticated user.
     *
     * @return User
     * @throws Exception
     */
    public function user()
    {
        $token = $this->request->header("token") ?? $this->request->get("token");
        if (!$token)
            throw new TokenException("Token Not found");
        try {
            $user = JWTUtil::getUser($token);
        }catch (Exception $exception){
            throw new TokenException("Invalid token");
        }

        if (!$user) {
            throw new TokenException("Invalid User Or Token Not Valid");
        }

        return $user;
    }

    /**
     * Get the ID for the currently authenticated user.
     *
     * @return int|string|null
     */
    public function id()
    {
        return $this->user()->id;
    }

    /**
     * Validate a user's credentials.
     *
     * @param array $credentials
     * @return bool
     */
    public function validate(array $credentials = [])
    {
        // TODO: Implement validate() method.
    }

    /**
     * Set the current user.
     *
     * @param \Illuminate\Contracts\Auth\Authenticatable $user
     * @return void
     */
    public function setUser(Authenticatable $user)
    {
        // TODO: Implement setUser() method.
    }
}