<?php

namespace App\Http\Controllers\Admin;

use App\Helper\traits\LoggingTrait;
use App\ProjectActivity;
use App\Traits\FileSystemSettingTrait;
use App\UniversalSearch;
use App\UserActivity;
use App\Http\Controllers\Controller;
use App\TaskHistory;
use Pusher\Pusher;

class AdminBaseController extends Controller
{
    use FileSystemSettingTrait, LoggingTrait;

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

    /**
     * UserBaseController constructor.
     */
    public function __construct()
    {
        parent::__construct();

        $this->companyName = $this->global->company_name;

        $this->middleware(function ($request, $next) {
            $this->setFileSystemConfigs();

            $this->languageSettings = language_setting();
            $this->adminTheme = admin_theme();
            $this->pushSetting = push_setting();
            $this->smtpSetting = smtp_setting();
            $this->pusherSettings = pusher_settings();
            $this->mainMenuSettings = main_menu_settings();
            $this->subMenuSettings = sub_menu_settings();
            $this->invoiceSetting = invoice_setting();
            $this->menuInnerSettingMenu = $this->innerSettingMenu();

            $this->user = user();
            $this->modules = $this->user->modules;
            $this->unreadNotificationCount = $this->user->unreadNotificationsCount;

            $this->stickyNotes = $this->user->sticky;

            $this->worksuitePlugins = worksuite_plugins();

            return $next($request);
        });
    }


    public function innerSettingMenu()
    {
        $route = \Illuminate\Support\Facades\Route::currentRouteName();
        $data = [];
        foreach ($this->subMenuSettings as $menu) {
            if ($menu['route'] == $route) {
                $data = $menu;
                break;
            }

            if (isset($menu['children'])) {
                foreach ($menu['children'] as $subMenu) {
                    if ($route == $subMenu['route']) {
                        $data = $menu;
                        break;
                    }
                }
            }
        }

        return $data;
    }
}
