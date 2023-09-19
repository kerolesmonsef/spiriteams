<?php

use App\Http\Controllers\API\ApiDepartmentController;
use App\Http\Controllers\API\ApiEmployeeController;
use App\Http\Controllers\API\ApiRoleController;
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\FollowUpController;
use App\Http\Controllers\API\FollowUpNoteController;
use App\Http\Controllers\API\HomeController;
use App\Http\Controllers\API\LeadController;
use App\Http\Controllers\API\NotificationController;
use App\Http\Controllers\API\PageController;
use App\Http\Controllers\API\PermissionController;
use App\Http\Controllers\API\ProjectController;
use App\Http\Controllers\API\TaskController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


ApiRoute::group(['namespace' => 'App\Http\Controllers'], function () {
    ApiRoute::get('purchased-module', ['as' => 'api.purchasedModule', 'uses' => 'HomeController@installedModule']);
});

Route::group(['prefix' => 'v1'], function () {
    Route::post('new_lead', [HomeController::class, 'index']);
});


Route::group(['middleware' => ['auth:token']], function () {

    Route::get("permissions", "API\PermissionController@index");
    Route::resource("roles", "API\ApiRoleController");
    Route::resource("designation", "API\ApiDesignationController");
    Route::post("roles/assignRole", "API\ApiRoleController@assignRole");
    Route::post("employee/create", "API\ApiEmployeeController@store");
    Route::resource("departments", "API\ApiDepartmentController");

    Route::get("auth/permissions", [PermissionController::class, "userPermissions"]);
    Route::get("home", [HomeController::class, "mobileHome"]);
    Route::get("notifications", [NotificationController::class, "index"]);
    Route::apiResource("projects", "API\ProjectController");
    Route::apiResource("projectCategory", "API\ProjectCategoryController");


    Route::get("leads/custom-fields", [LeadController::class, "getCustomFields"]);
    Route::get("leads/create", "API\LeadController@create");
    Route::apiResource("leads", "API\LeadController");
    Route::apiResource("{lead}/follow-up", "API\FollowUpController");

    Route::post("followup-note", [FollowUpNoteController::class,'store']);
    Route::delete("followup-note/{id}", [FollowUpNoteController::class,'destroy']);
    Route::put("followup-note/{id}", [FollowUpNoteController::class,'update']);

    Route::get("/get-employees", [ApiEmployeeController::class, 'getEmployees']);

    Route::apiResource("tasks", "API\TaskController");
    Route::apiResource("taskBoards", "API\TaskBoardColumnController");
    Route::get("tasks/{task}/history", [TaskController::class, "history"]);

    Route::post("tasks/{task}/update-priority", [TaskController::class, "updateIndex"]);

    Route::get("tasks/{task}/history", [TaskController::class, "history"]);
    Route::get("tasks/{task}/comments", [TaskController::class, "comments"]);
    Route::post("tasks/{task}/comments", [TaskController::class, "makeComment"]);
    Route::get("tasks_board", [TaskController::class, "board"]);
    Route::get("me", [AuthController::class, 'me']);
    Route::post("toggle-emailNotification", [AuthController::class, 'toggleEmailNotification']);
    Route::get("/employees", [ApiEmployeeController::class, 'index']);
});

Route::get("/get-employees", [ApiEmployeeController::class, 'getEmployees']);

//Route::get("/employees", [ApiEmployeeController::class, 'index']);


Route::get("base-url", "API\TenantController@getBaseUrl");
Route::post("tenant-create", "API\TenantController@createTenant");

//******************** Tenant ******************** //

Route::group(['middleware' => ['initialize-tenant', 'api']], function () {

    Route::post('/dd', function () {
        //    dd('aa');
        return 'This is your multi-tenant application. The id of the current tenant is ' . tenant('id');
    });


 
});


Route::get("pages", "API\PageController");
