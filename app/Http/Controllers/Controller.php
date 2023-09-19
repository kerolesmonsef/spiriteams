<?php

namespace App\Http\Controllers;

use App\Helper\traits\UniversalSearchTrait;
use App\SocialAuthSetting;
use App\UniversalSearch;
use App\UserActivity;
use Carbon\Carbon;
use Froiden\Envato\Traits\AppBoot;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Support\Facades\App;

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests, AppBoot, UniversalSearchTrait;

    /**
     * @var array
     */
    public $data = [];

    /**
     * @param $name
     * @param $value
     */
    public function __set($name, $value)
    {
        $this->data[$name] = $value;
    }

    /**
     * @param $name
     * @return mixed
     */
    public function __get($name)
    {
        return $this->data[$name];
    }

    /**
     * @param $name
     * @return bool
     */
    public function __isset($name)
    {
        return isset($this->data[$name]);
    }

    public function __construct()
    {

        $this->showInstall();
        $this->checkMigrateStatus();
        $this->global = getCachedSettings();

        $this->gdpr = cache()->remember(
            'gdpr-setting', 60 * 60 * 24, function () {
            return \App\GdprSetting::first();
        }
        );
        $this->socialAuthSettings = SocialAuthSetting::first();

        $this->middleware(function ($request, $next) {


            config(['app.name' => $this->global->company_name]);
            config(['app.url' => url('/')]);

            App::setLocale($this->global->locale);
            Carbon::setLocale($this->global->locale);
            setlocale(LC_TIME, $this->global->locale . '_' . strtoupper($this->global->locale));

            if (config('app.env') !== 'development') {
                config(['app.debug' => $this->global->app_debug]);
            }

            if (auth()->user()) {
                config(['froiden_envato.allow_users_id' => true]);
            }
            return $next($request);
        });
    }

    public function checkMigrateStatus()
    {
        return check_migrate_status();
    }

    public function logUserActivity($userId, $text)
    {
        $activity = new UserActivity();
        $activity->user_id = $userId;
        $activity->activity = $text;
        $activity->save();
    }


}
