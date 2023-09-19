<?php

namespace App\Providers;

use App\Observers\SettingsObserver;
use App\Setting;
use Illuminate\Database\Events\QueryExecuted;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Response;
use Illuminate\Pagination\LengthAwarePaginator;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
//        DB::listen(function (QueryExecuted $query){
//            info($query->sql);
//        });
        if (\config('app.redirect_https')) {
            \URL::forceScheme('https');
        }
        Schema::defaultStringLength(191);

        Setting::observe(SettingsObserver::class);
        $this->add_response_statuses();

    }

    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        if (\config('app.redirect_https')) {
            $this->app['request']->server->set('HTTPS', true);
        }
    }

    private function add_response_statuses()
    {
        Response::macro("success", function (array $extra = [],$message = null) {
            return response()->json(array_merge([
                'status'    => true,
                'message' => $message,
            ], $extra), 200);
        });

        Response::macro("fail", function (array $extra = [], int $code = 400) {
            return response()->json(array_merge([
                'status' => false,
            ], $extra), $code);
        });


        Collection::macro('paginate', function($perPage = 15, $total = null, $page = null, $pageName = 'page') {
            $page = $page ?: LengthAwarePaginator::resolveCurrentPage($pageName);

            return new LengthAwarePaginator(
                $this->forPage($page, $perPage),
                $total ?: $this->count(),
                $perPage,
                $page,
                [
                    'path' => LengthAwarePaginator::resolveCurrentPath(),
                    'pageName' => $pageName,
                ]
            );
        });


    }
}
