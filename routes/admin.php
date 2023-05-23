<?php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\admin\ManageServerController;
use App\Http\Controllers\admin\ManageTopicController;
use App\Http\Controllers\admin\ViewTopicController;
use App\Http\Controllers\admin\ManageUserController;
use App\Http\Controllers\admin\ManageLineController;
use App\Http\Controllers\admin\ManageMachineController;
use App\Http\Controllers\admin\ManageProductController;
use App\Http\Controllers\admin\ManageKpiController;
use App\Http\Controllers\admin\ManageOeeController;
use App\Http\Controllers\admin\ManageActivityController;
use App\Http\Controllers\OeeController;
use App\Http\Controllers\admin\ManageShiftController;
use App\Http\Controllers\admin\ManagePlanningController;
use App\Http\Controllers\admin\ViewOeeController;
use App\Http\Controllers\admin\AchievementPoeController;
use App\Http\Controllers\admin\AchievementOeeController;
use App\Http\Controllers\admin\AssignOperatorController;
use App\Http\Controllers\admin\ManageLevelController;
use App\Http\Controllers\admin\ManageDailyController;
use App\Http\Controllers\admin\ViewDowntimeController as ViewDowntime;

Route::group(['prefix' => 'admin'], function () {

    //Name: Manage
    Route::name('manage.')->group(function(){
        //Manage Users
        Route::resource('user', ManageUserController::class)->only(['index', 'store', 'edit', 'update', 'destroy']);
        Route::put('users/password/{id}', [ManageUserController::class,'updatePassword',])->name('password.update');

        //manage Lines
        Route::resource('line', ManageLineController::class)->only(['index', 'store', 'edit', 'update', 'destroy']);

        //manage Machines
        Route::resource('machine', ManageMachineController::class)->only(['index', 'store', 'edit', 'update', 'destroy']);

        //Manage Activity Code
        Route::resource('activity', ManageActivityController::class)->only(['index', 'store', 'edit', 'update', 'destroy']);
        Route::get('activity/list/{param}', [ManageActivityController::class,'getListActivity'])->name('activity.list');
        Route::get('activity/{id_line}/line', [ManageActivityController::class, 'getActivityByLine'])->name('activity.line');

        //Management Level and Access Menu
        Route::resource('level', ManageLevelController::class)->only(['index', 'store', 'edit', 'update', 'destroy']);

        //Manage Shift
        Route::resource('shift', ManageShiftController::class)->only(['index', 'store', 'edit', 'update', 'destroy']);
        Route::get('shift/reset', [ManageShiftController::class, 'getResetCount'])->name('manage.shift.reset');

        //Manage product
        Route::resource('product', ManageProductController::class)->only(['index', 'store', 'edit', 'update', 'destroy']);

        //Manage KPI
        Route::resource('kpi', ManageKpiController::class)->only(['index', 'store', 'edit', 'update', 'destroy']);

        //Manage KPI Detail
        Route::get('kpi/detail/{year}', [ManageKpiController::class, 'getKpiDetail'])->name('kpi.detail');
        Route::get('kpi/detail/list/{idkpi}', [ManageKpiController::class, 'getListKpiDetail'])->name('kpi_detail.list');
        Route::post('kpi/detail', [ManageKpiController::class, 'storeKpiDetail'])->name('kpi_detail.store');
        Route::get('kpi/detail/data/{id}', [ManageKpiController::class, 'editKpiDetail'])->name('kpi_detail.edit');
        Route::put('kpi/detail/{id}', [ManageKpiController::class, 'updateKpiDetail'])->name('kpi_detail.update');
        Route::delete('kpi/detail/{id}', [ManageKpiController::class, 'destroyKpiDetail'])->name('kpi_detail.destroy');

        //Management Broker
        Route::resource('server', ManageServerController::class)->only(['index', 'store', 'edit', 'update', 'destroy']);
        Route::put('/server/switch/{id}', [ManageServerController::class, 'switchServer'])->name('server.switch');
        Route::get('/server/activate/{param}', [ManageServerController::class, 'activateServer'])->name('server.activate');
        Route::get('/server/check/status', [ManageServerController::class, 'checkServerStatus'])->name('server.status');

        //Management Topic
        Route::resource('topic', ManageTopicController::class)->only(['index', 'store', 'edit', 'update', 'destroy']);

        //Manage Daily Activities
        Route::resource('daily-activity', ManageDailyController::class)->only(['index', 'store', 'edit', 'update', 'destroy']);
    });

    //Input Oee HandsonTable
    Route::get('input', [OeeController::class, 'getIndex'])->name('input.oee');
    Route::post('input/activitycode', [OeeController::class, 'getActivity'])->name('input.oee.activity');
    Route::get('oee/list', [OeeController::class, 'getOeeList'])->name('input.oee.list');
    Route::post('oee', [OeeController::class, 'storeOee'])->name('input.oee.store');

    //Manajemen OEE per Month
    Route::get('oeemanagement', [ManageOeeController::class, 'getIndex'])->name('management.oee.month');
    Route::get('oeemanagement/{month}', [ManageOeeController::class, 'getOeeManagement'])->name('management.oee.detail');
    Route::post('oeemanagement/list', [ManageOeeController::class, 'getOeeList'])->name('management.oee.list');
    Route::post('oeemanagement/store', [ManageOeeController::class, 'storeOee'])->name('management.oee.store');
    Route::post('oeemanagement/destroys', [ManageOeeController::class, 'destroyRows'])->name('management.oee.destroy');
    Route::get('oeedriermanagement/{month}', [ManageOeeController::class, 'getDrierManagement'])->name('management.drier.detail');
    Route::post('oeedriermanagement/list', [ManageOeeController::class, 'getDrierList'])->name('management.drier.list');
    Route::post('oeedriermanagement/store', [ManageOeeController::class, 'storeDrier'])->name('management.drier.store');

    //Manajemen Planning
    Route::get('planning', [ManagePlanningController::class, 'getIndex'])->name('management.planning.index');
    Route::get('planning/list/{status}', [ManagePlanningController::class, 'getListPlanning'])->name('management.planning.list');

    //View DB OEE
    Route::get('viewoee', [ViewOeeController::class, 'getIndex'])->name('view.oee.index');
    Route::post('viewoee/list', [ViewOeeController::class, 'listViewOee'])->name('view.oee.list');

    //Achievement: Achievement OEE
    Route::get('achievementoee', [AchievementOeeController::class, 'getIndex'])->name('view.achievement.oee');
    Route::post('achievementoee/list', [AchievementOeeController::class, 'getListOee'])->name('view.achievement.oee.list');

    //Achievement: Achievement POE
    Route::get('achievementpoe', [AchievementPoeController::class, 'getAchievementPoe'])->name('view.achievement.poe');
    Route::post('achievementpoe/list', [AchievementPoeController::class, 'postListPoe'])->name('view.achievement.poe.list');

    //Achievement POE
    Route::get('viewpoe', [AchievementPoeController::class, 'getIndex'])->name('achievement.poe.index');
    Route::get('viewpoe/columns', [AchievementPoeController::class, 'getColumns'])->name('achievement.poe.columns');
    Route::post('viewpoe/list', [AchievementPoeController::class, 'getListPoe'])->name('achievement.poe.list');

    //View Downtime
    Route::get('viewdowntime', [ViewDowntime::class, 'getIndex'])->name('admin.view.downtime');
    Route::post('viewdowntime/list', [ViewDowntime::class, 'postListDowntime'])->name('admin.view.downtime.list');

    //View Topic Results
    Route::get('/topic-results', [ViewTopicController::class, 'getResults'])->name('view.topic.result');
    Route::post('/topic-results/detail', [ViewTopicController::class, 'getDetail'])->name('view.topic.result.detail');

    //Assign Operator to Line
    Route::get('/assign/operator', [AssignOperatorController::class, 'getAssign'])->name('assign.operator.index');
    Route::get('/assign/checker/option/{id}', [AssignOperatorController::class, 'getCheckerOption'])->name('assign.checker.option');
    Route::post('/assign/operator/{id}', [AssignOperatorController::class, 'storeAssignOperator'])->name('assign.operator.store');
    Route::get('/assign/operator/{id}', [AssignOperatorController::class, 'editAssignOperator'])->name('assign.operator.edit');
});
