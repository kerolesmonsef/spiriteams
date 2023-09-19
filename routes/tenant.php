<?php

declare(strict_types=1);

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Tenant Routes
|--------------------------------------------------------------------------
|
| Here you can register the tenant routes for your application.
| These routes are loaded by the TenantRouteServiceProvider.
|
| Feel free to customize them however you want. Good luck!
|
*/

//Route::middleware([
//    'web',
//    \Stancl\Tenancy\Middleware\InitializeTenancyByDomain::class,
//])->group(function () {
//    Route::get('/dd', function () {
//
//
//        dd(config("database"));
//        return 'This is your multi-tenant application. The id of the current tenant is ' . tenant('id');
//    });
//});
