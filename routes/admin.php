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
    //Manage Users
    Route::get('users', [ManageUserController::class, 'getIndex'])->name('manage.user.index');
    Route::post('users', [ManageUserController::class, 'storeUser'])->name('manage.user.store');
    Route::get('users/{id}', [ManageUserController::class, 'editUser'])->name('manage.user.edit');
    Route::put('users/{id}', [ManageUserController::class, 'updateUser'])->name('manage.user.update');
    Route::put('users/password/{id}', [ManageUserController::class,'updatePassword',])->name('manage.password.update');
    Route::delete('users/{id}', [ManageUserController::class,'destroyUser',])->name('manage.user.destroy');

    //Manage Line Process
    Route::get('line', [ManageLineController::class, 'getIndex'])->name('manage.line.index');
    Route::post('line', [ManageLineController::class, 'storeLine'])->name('manage.line.store');
    Route::get('line/{id}', [ManageLineController::class, 'editLine'])->name('manage.line.edit');
    Route::put('line/{id}', [ManageLineController::class, 'updateLine'])->name('manage.line.update');
    Route::delete('line/{id}', [ManageLineController::class,'destroyLine'])->name('manage.line.destroy');

    //Manage Machines
    Route::get('machines', [ManageMachineController::class, 'getIndex'])->name('manage.machine.index');
    Route::get('machines/list', [ManageMachineController::class, 'getListMachines'])->name('manage.machine.list');
    Route::post('machines', [ManageMachineController::class,'storeMachine'])->name('manage.machine.store');
    Route::get('machines/{id}', [ManageMachineController::class,'editMachine'])->name('manage.machine.edit');
    Route::put('machines/{id}', [ManageMachineController::class,'updateMachine'])->name('manage.machine.update');
    Route::delete('machines/{id}', [ManageMachineController::class,'destroyMachine'])->name('manage.machine.destroy');

    //Manage Activity Code
    Route::get('activity', [ManageActivityController::class, 'getIndex'])->name('manage.activity.index');
    Route::get('activity/list/{param}', [ManageActivityController::class,'getListActivity'])->name('manage.activity.list');
    Route::post('activity', [ManageActivityController::class,'storeActivity'])->name('manage.activity.store');
    Route::get('activity/{id}', [ManageActivityController::class,'editActivity'])->name('manage.activity.edit');
    Route::put('activity/{id}', [ManageActivityController::class,'updateActivity'])->name('manage.activity.update');
    Route::delete('activity/{id}', [ManageActivityController::class,'destroyActivity'])->name('manage.activity.destroy');

    //Manage Product
    Route::get('product', [ManageProductController::class, 'getIndex'])->name('manage.product.index');
    Route::post('product', [ManageProductController::class,'storeProduct'])->name('manage.product.store');
    Route::get('product/{id}', [ManageProductController::class,'editProduct'])->name('manage.product.edit');
    Route::put('product/{id}', [ManageProductController::class,'updateProduct'])->name('manage.product.update');
    Route::delete('product/{id}', [ManageProductController::class,'destroyProduct'])->name('manage.product.destroy');

    //Manage Shift
    Route::get('shift', [ManageShiftController::class, 'getIndex'])->name('manage.shift.index');
    Route::post('shift', [ManageShiftController::class, 'storeShift'])->name('manage.shift.store');
    Route::get('shift/{id}', [ManageShiftController::class, 'editShift'])->name('manage.shift.edit');
    Route::put('shift/{id}', [ManageShiftController::class, 'updateShift'])->name('manage.shift.update');
    Route::delete('shift/{id}', [ManageShiftController::class, 'destroyShift'])->name('manage.shift.destroy');

    //Manage KPI
    Route::get('kpi', [ManageKpiController::class, 'getIndex'])->name('manage.kpi.index');
    Route::get('kpi/list', [ManageKpiController::class, 'getListKpi'])->name('manage.kpi.list');
    Route::post('kpi', [ManageKpiController::class, 'storeKpi'])->name('manage.kpi.store');
    Route::get('kpi/{id}', [ManageKpiController::class, 'editKpi'])->name('manage.kpi.edit');
    Route::put('kpi/{id}', [ManageKpiController::class, 'updateKpi'])->name('manage.kpi.update');
    Route::delete('kpi/{id}', [ManageKpiController::class, 'destroyKpi'])->name('manage.kpi.destroy');

    //Manage KPI Detail
    Route::get('kpi/detail/{year}', [ManageKpiController::class, 'getKpiDetail'])->name('manage.kpi.detail');
    Route::get('kpi/detail/list/{idkpi}', [ManageKpiController::class, 'getListKpiDetail'])->name('manage.kpi_detail.list');
    Route::post('kpi/detail', [ManageKpiController::class, 'storeKpiDetail'])->name('manage.kpi_detail.store');
    Route::get('kpi/detail/data/{id}', [ManageKpiController::class, 'editKpiDetail'])->name('manage.kpi_detail.edit');
    Route::put('kpi/detail/{id}', [ManageKpiController::class, 'updateKpiDetail'])->name('manage.kpi_detail.update');
    Route::delete('kpi/detail/{id}', [ManageKpiController::class, 'destroyKpiDetail'])->name('manage.kpi_detail.destroy');

    //Input Oee HandsonTable
    Route::get('input', [OeeController::class, 'getIndex'])->name('input.oee');
    Route::post('input/activitycode', [OeeController::class, 'getActivity'])->name('input.oee.activity');
    Route::get('oee/list', [OeeController::class, 'getOeeList'])->name('input.oee.list');
    Route::post('oee', [OeeController::class, 'storeOee'])->name('input.oee.store');

    //Management Level and Access Menu
    Route::get('/levels', [ManageLevelController::class, 'getLevel'])->name('manage.level.index');
    Route::get('/levels/list', [ManageLevelController::class, 'getLevelList'])->name('manage.level.list');
    Route::post('/level', [ManageLevelController::class, 'storeLevel'])->name('manage.level.store');
    Route::get('/level/{id}', [ManageLevelController::class, 'editLevel'])->name('manage.level.edit');
    Route::put('/level/{id}', [ManageLevelController::class, 'updateLevel'])->name('manage.level.update');
    Route::delete('/level/{id}', [ManageLevelController::class, 'destroyLevel'])->name('manage.level.destroy');

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

    //Management Broker
    Route::get('/server', [ManageServerController::class, 'getServer'])->name('manage.server.index');
    Route::post('/server', [ManageServerController::class, 'storeServer'])->name('manage.server.store');
    Route::get('/server/{id}', [ManageServerController::class, 'editServer'])->name('manage.server.edit');
    Route::put('/server/{id}', [ManageServerController::class, 'updateServer'])->name('manage.server.update');
    Route::put('/server/switch/{id}', [ManageServerController::class, 'switchServer'])->name('manage.server.switch');
    Route::get('/server/activate/{param}', [ManageServerController::class, 'activateServer'])->name('manage.server.activate');
    Route::get('/server/check/status', [ManageServerController::class, 'checkServerStatus'])->name('manage.server.status');
    Route::delete('/server/{id}', [ManageServerController::class, 'destroyServer'])->name('manage.server.destroy');

    //Management Topic
    Route::get('/topic', [ManageTopicController::class, 'getTopic'])->name('manage.topic.index');
    Route::post('/topic', [ManageTopicController::class, 'storeTopic'])->name('manage.topic.store');
    Route::get('/topic/{id}', [ManageTopicController::class, 'editTopic'])->name('manage.topic.edit');
    Route::put('/topic/{id}', [ManageTopicController::class, 'updateTopic'])->name('manage.topic.update');
    Route::delete('/topic/{id}', [ManageTopicController::class, 'destroyTopic'])->name('manage.topic.destroy');

    //View Topic Results
    Route::get('/topic-results', [ViewTopicController::class, 'getResults'])->name('view.topic.result');
    Route::post('/topic-results/detail', [ViewTopicController::class, 'getDetail'])->name('view.topic.result.detail');

    //Assign Operator to Line
    Route::get('/assign/operator', [AssignOperatorController::class, 'getAssign'])->name('assign.operator.index');
    Route::get('/assign/checker/option/{id}', [AssignOperatorController::class, 'getCheckerOption'])->name('assign.checker.option');
    Route::post('/assign/operator/{id}', [AssignOperatorController::class, 'storeAssignOperator'])->name('assign.operator.store');
    Route::get('/assign/operator/{id}', [AssignOperatorController::class, 'editAssignOperator'])->name('assign.operator.edit');

    //Manage Daily Activites
    Route::get('/daily-activities', [ManageDailyController::class, 'getIndex'])->name('daily.activities.index');
});
