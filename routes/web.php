<?php

use App\Http\Controllers\admin\ManageActivityController;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\admin\ManageUserController;
use App\Http\Controllers\admin\ManageLineController;
use App\Http\Controllers\admin\ManageMachineController;
use App\Http\Controllers\admin\ManageProductController;
use App\Http\Controllers\admin\ManageKpiController;
use App\Http\Controllers\admin\ManageOeeController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\OeeController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\operator\OperatorController;
use App\Http\Controllers\operator\OperatorDrierController;
use App\Http\Controllers\admin\ManageShiftController;
use App\Http\Controllers\admin\ManagePlanningController;
use App\Http\Controllers\admin\ViewOeeController;
use App\Http\Controllers\admin\AchievementPoeController;
use App\Http\Controllers\admin\AchievementOeeController;
use App\Http\Controllers\admin\ManageLevelController;
use App\Http\Controllers\leader\LeaderController;
use App\Http\Controllers\leader\LeaderDrierController;
use App\Http\Controllers\leader\ViewDowntimeController as LeaderViewDowntime;
use App\Http\Controllers\leader\ViewOeeController as LeaderDBOee;
use App\Http\Controllers\admin\ViewDowntimeController as ViewDowntime;
use App\Http\Controllers\LineDashboardController as ViewLine;
use App\Http\Controllers\adminCg\OeeController as adminCgOee;
use App\Http\Controllers\adminCg\OeeDrierController as adminCgOeeDrier;
use App\Http\Controllers\adminCg\ViewOeeController as adminCgViewOee;
use App\Http\Controllers\adminCg\ViewDowntimeController as adminCgDowntime;
use App\Http\Controllers\leaderCg\OeeController as leaderCgOee;
use App\Http\Controllers\leaderCg\OeeDrierController as leaderCgOeeDrier;
use App\Http\Controllers\leaderCg\ViewOeeController as leaderCgViewOee;
use App\Http\Controllers\leaderCg\ViewDowntimeController as leaderCgDowntime;
use App\Http\Controllers\admin\ManageServerController;
use App\Http\Controllers\admin\ManageTopicController;
use App\Http\Controllers\admin\ViewTopicController;
use App\Http\Controllers\Ppic\ManagePlanOrderController;
use Illuminate\Database\Capsule\Manager;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', [AuthController::class, 'getIndex'])->name('auth.login');
Route::get('/line/{line_id}', [ViewLine::class, 'getIndex'])->name(
    'auth.line.view'
);
Route::post('/chart-poe', [AuthController::class, 'getChartPOE'])->name('chart.poe');
Route::post('/chart-ur', [AuthController::class, 'getChartUR'])->name('chart.urate');
Route::post('/login', [AuthController::class, 'postLogin'])->name(
    'auth.post.login'
);
Route::get('/login/data', [AuthController::class, 'getData'])->name(
    'auth.get.api'
);
Route::get('/logout', [AuthController::class, 'getLogout'])->name(
    'auth.logout'
);

Route::get('dashboard', [DashboardController::class, 'getIndex'])->name(
    'dashboard.index'
);
Route::get('dashboard/line/{line_id}', [ViewLine::class, 'getIndex'])->name(
    'dashboard.line.view'
);
Route::post('/postline', [DashboardController::class, 'setLineOrLeader'])->name('dashboard.post.line');
//Profile User
Route::get('/profile',[UserController::class, 'getProfile'])->name('user.profile');
Route::put('/profile/update-profile/{id}',[UserController::class, 'updateProfile'])->name('user.update.profile');
Route::put('/profile/update-password/{id}',[UserController::class, 'updatePassword'])->name('user.update.password');
Route::group(['prefix' => 'admin'], function () {

    //Manage Users
    Route::get('users', [ManageUserController::class, 'getIndex'])->name(
        'manage.user.index'
    );
    Route::get('users/list', [
        ManageUserController::class,
        'getListUsers',
    ])->name('manage.user.list');
    Route::post('users', [ManageUserController::class, 'storeUser'])->name(
        'manage.user.store'
    );
    Route::get('users/{id}', [ManageUserController::class, 'editUser'])->name(
        'manage.user.edit'
    );
    Route::put('users/{id}', [ManageUserController::class, 'updateUser'])->name(
        'manage.user.update'
    );
    Route::put('users/password/{id}', [
        ManageUserController::class,
        'updatePassword',
    ])->name('manage.password.update');
    Route::delete('users/{id}', [
        ManageUserController::class,
        'destroyUser',
    ])->name('manage.user.destroy');

    //Manage Line Process
    Route::get('line', [ManageLineController::class, 'getIndex'])->name(
        'manage.line.index'
    );
    Route::get('line/list', [
        ManageLineController::class,
        'getListLines',
    ])->name('manage.line.list');
    Route::post('line', [ManageLineController::class, 'storeLine'])->name(
        'manage.line.store'
    );
    Route::get('line/{id}', [ManageLineController::class, 'editLine'])->name(
        'manage.line.edit'
    );
    Route::put('line/{id}', [ManageLineController::class, 'updateLine'])->name(
        'manage.line.update'
    );
    Route::delete('line/{id}', [
        ManageLineController::class,
        'destroyLine',
    ])->name('manage.line.destroy');

    //Manage Machines
    Route::get('machines', [ManageMachineController::class, 'getIndex'])->name(
        'manage.machine.index'
    );
    Route::get('machines/list', [
        ManageMachineController::class,
        'getListMachines',
    ])->name('manage.machine.list');
    Route::post('machines', [
        ManageMachineController::class,
        'storeMachine',
    ])->name('manage.machine.store');
    Route::get('machines/{id}', [
        ManageMachineController::class,
        'editMachine',
    ])->name('manage.machine.edit');
    Route::put('machines/{id}', [
        ManageMachineController::class,
        'updateMachine',
    ])->name('manage.machine.update');
    Route::delete('machines/{id}', [
        ManageMachineController::class,
        'destroyMachine',
    ])->name('manage.machine.destroy');

    //Manage Activity Code
    Route::get('activity', [ManageActivityController::class, 'getIndex'])->name(
        'manage.activity.index'
    );
    Route::get('activity/list/{param}', [
        ManageActivityController::class,
        'getListActivity',
    ])->name('manage.activity.list');
    Route::post('activity', [
        ManageActivityController::class,
        'storeActivity',
    ])->name('manage.activity.store');
    Route::get('activity/{id}', [
        ManageActivityController::class,
        'editActivity',
    ])->name('manage.activity.edit');
    Route::put('activity/{id}', [
        ManageActivityController::class,
        'updateActivity',
    ])->name('manage.activity.update');
    Route::delete('activity/{id}', [
        ManageActivityController::class,
        'destroyActivity',
    ])->name('manage.activity.destroy');

    //Manage Product
    Route::get('product', [ManageProductController::class, 'getIndex'])->name(
        'manage.product.index'
    );
    Route::post('product', [
        ManageProductController::class,
        'storeProduct',
    ])->name('manage.product.store');
    Route::get('product/{id}', [
        ManageProductController::class,
        'editProduct',
    ])->name('manage.product.edit');
    Route::put('product/{id}', [
        ManageProductController::class,
        'updateProduct',
    ])->name('manage.product.update');
    Route::delete('product/{id}', [
        ManageProductController::class,
        'destroyProduct',
    ])->name('manage.product.destroy');

    //Manage Shift
    Route::get('shift', [ManageShiftController::class, 'getIndex'])->name(
        'manage.shift.index'
    );
    Route::post('shift', [ManageShiftController::class, 'storeShift'])->name(
        'manage.shift.store'
    );
    Route::get('shift/{id}', [ManageShiftController::class, 'editShift'])->name(
        'manage.shift.edit'
    );
    Route::put('shift/{id}', [ManageShiftController::class, 'updateShift'])->name(
        'manage.shift.update'
    );
    Route::delete('shift/{id}', [ManageShiftController::class, 'destroyShift'])->name(
        'manage.shift.destroy'
    );

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
    Route::get('oee/list', [OeeController::class, 'getOeeList'])->name(
        'input.oee.list'
    );
    Route::post('oee', [OeeController::class, 'storeOee'])->name(
        'input.oee.store'
    );

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
});

//Prefix Operator
Route::group(['prefix' => 'operator'], function () {
    //Operator Input OEE
    Route::get('month', [OperatorController::class, 'getMonth'])->name('operator.month');
    Route::get('month/{month}', [OperatorController::class, 'getDate'])->name('operator.date');
    Route::get('month/{month}/list', [OperatorController::class, 'getDateList'])->name('operator.date.list');
    Route::post('oee/okp', [OperatorController::class, 'getOkpDetail'])->name('operator.oee.okp');
    Route::post('oee/list', [OperatorController::class, 'getOeeList'])->name('operator.oee.list');
    Route::post('oee/store', [OperatorController::class, 'storeOee'])->name('operator.oee.store');
    Route::delete('oee/destroy/{id}', [OperatorController::class, 'destroyOee'])->name('operator.oee.destroy');

    //Operator Drier Input OEE
    Route::get('month-drier', [OperatorDrierController::class, 'getMonth'])->name('operator.drier.month');
    Route::get('month-drier/{month}', [OperatorDrierController::class, 'getDate'])->name('operator.drier.date');
    Route::post('oee-drier/okp', [OperatorDrierController::class, 'getOkpDetail'])->name('operator.drier.oee.okp');
    Route::post('oee-drier/list', [OperatorDrierController::class, 'getOeeList'])->name('operator.drier.oee.list');
    Route::post('oee-drier/store', [OperatorDrierController::class, 'storeOee'])->name('operator.drier.oee.store');
});

//Prefix: Leader
Route::group(['prefix' => 'leader'], function () {
    //Leader: Input OEE
    Route::get('month', [LeaderController::class, 'getMonth'])->name('leader.month');
    Route::get('month/{month}', [LeaderController::class, 'getDate'])->name('leader.date');
    Route::get('month/{month}/list', [LeaderController::class, 'getDateList'])->name('leader.date.list');
    Route::post('oee/okp', [LeaderController::class, 'getOkpDetail'])->name('leader.oee.okp');
    Route::post('oee/list', [LeaderController::class, 'getOeeList'])->name('leader.oee.list');
    Route::post('oee/store', [LeaderController::class, 'storeOee'])->name('leader.oee.store');
    Route::delete('oee/destroy/{id}', [LeaderController::class, 'destroyOee'])->name('leader.oee.destroy');

    //Leader: DB OEE View
    Route::get('viewoee', [LeaderDBOee::class, 'getIndex'])->name('leader.view.dboee');
    Route::post('viewoee/list', [LeaderDBOee::class, 'listViewOee'])->name('leader.list.dboee');

    //View Downtime
    Route::get('viewdowntime', [LeaderViewDowntime::class, 'getIndex'])->name('leader.view.downtime');
    Route::post('viewdowntime/list', [LeaderViewDowntime::class, 'postListDowntime'])->name('leader.view.downtime.list');
});

//Prefix: Leader
Route::group(['prefix' => 'leader-drier'], function () {
    //Leader: Input OEE
    Route::get('month', [LeaderDrierController::class, 'getMonth'])->name('leaderDrier.month');
    Route::get('month/{month}', [LeaderDrierController::class, 'getDate'])->name('leaderDrier.date');
    Route::get('month/{month}/list', [LeaderDrierController::class, 'getDateList'])->name('leaderDrier.date.list');
    Route::post('oee/okp', [LeaderDrierController::class, 'getOkpDetail'])->name('leaderDrier.oee.okp');
    Route::post('oee/list', [LeaderDrierController::class, 'getOeeList'])->name('leaderDrier.oee.list');
    Route::post('oee/store', [LeaderDrierController::class, 'storeOee'])->name('leaderDrier.oee.store');
    Route::delete('oee/destroy/{id}', [LeaderDrierController::class, 'destroyOee'])->name('leaderDrier.oee.destroy');

    //Leader: DB OEE View
    Route::get('viewoee', [LeaderDBOee::class, 'getIndex'])->name('leader.view.dboee');
    Route::post('viewoee/list', [LeaderDBOee::class, 'listViewOee'])->name('leader.list.dboee');
});

//Prefix: Admin CG
Route::group(['prefix' => 'admin-cg'], function () {
    //Admin CG: Input OEE
    Route::get('month', [adminCgOee::class, 'getMonth'])->name('admin-cg.month');
    Route::get('month/{month}', [adminCgOee::class, 'getDate'])->name('admin-cg.date');
    Route::get('month/{month}/list', [adminCgOee::class, 'getDateList'])->name('admin-cg.date.list');
    Route::post('oee/okp', [adminCgOee::class, 'getOkpDetail'])->name('admin-cg.oee.okp');
    Route::post('oee/list', [adminCgOee::class, 'getOeeList'])->name('admin-cg.oee.list');
    Route::post('oee/store', [adminCgOee::class, 'storeOee'])->name('admin-cg.oee.store');
    Route::delete('oee/destroy/{id}', [adminCgOee::class, 'destroyOee'])->name('admin-cg.oee.destroy');

    //Admin CG: Input OEE Drier
    Route::get('month-drier', [adminCgOeeDrier::class, 'getMonth'])->name('admin-cg.drier.month');
    Route::get('month-drier/{month}', [adminCgOeeDrier::class, 'getDate'])->name('admin-cg.drier.date');
    Route::get('month-drier/{month}/list', [adminCgOeeDrier::class, 'getDateList'])->name('admin-cg.drier.date.list');
    Route::post('oee-drier/okp', [adminCgOeeDrier::class, 'getOkpDetail'])->name('admin-cg.drier.oee.okp');
    Route::post('oee-drier/list', [adminCgOeeDrier::class, 'getOeeList'])->name('admin-cg.drier.oee.list');
    Route::post('oee-drier/store', [adminCgOeeDrier::class, 'storeOee'])->name('admin-cg.drier.oee.store');
    Route::delete('oee-drier/destroy/{id}', [adminCgOeeDrier::class, 'destroyOee'])->name('admin-cg.drier.oee.destroy');

    //Admin CG: DB OEE View
    Route::get('viewoee', [adminCgViewOee::class, 'getIndex'])->name('adminCg.view.dboee');
    Route::post('viewoee/list', [adminCgViewOee::class, 'listViewOee'])->name('adminCg.list.dboee');

    //Admin CG: View Downtime Analysis
    Route::get('viewdowntime', [adminCgDowntime::class, 'getIndex'])->name('adminCg.view.downtime');
    Route::post('viewdowntime/list', [adminCgDowntime::class, 'postListDowntime'])->name('adminCg.view.downtime.list');
});

//Prefix: Leader CG
Route::group(['prefix' => 'leader-cg'], function () {
    //Leader CG: Input OEE
    Route::get('month', [leaderCgOee::class, 'getMonth'])->name('leaderCg.month');
    Route::get('month/{month}', [leaderCgOee::class, 'getDate'])->name('leaderCg.date');
    Route::get('month/{month}/list', [leaderCgOee::class, 'getDateList'])->name('leaderCg.date.list');
    Route::post('oee/okp', [leaderCgOee::class, 'getOkpDetail'])->name('leaderCg.oee.okp');
    Route::post('oee/list', [leaderCgOee::class, 'getOeeList'])->name('leaderCg.oee.list');
    Route::post('oee/store', [leaderCgOee::class, 'storeOee'])->name('leaderCg.oee.store');
    Route::delete('oee/destroy/{id}', [leaderCgOee::class, 'destroyOee'])->name('leaderCg.oee.destroy');

    //Leader CG: DB OEE View
    Route::get('viewoee', [leaderCgViewOee::class, 'getIndex'])->name('leaderCg.view.dboee');
    Route::post('viewoee/list', [leaderCgViewOee::class, 'listViewOee'])->name('leaderCg.list.dboee');

    //Leader CG: View Downtime Analysis
    Route::get('viewdowntime', [leaderCgDowntime::class, 'getIndex'])->name('leaderCg.view.downtime');
    Route::post('viewdowntime/list', [leaderCgDowntime::class, 'postListDowntime'])->name('leaderCg.view.downtime.list');

    //Leader CG: Input OEE Drier
    Route::get('month-drier', [leaderCgOeeDrier::class, 'getMonth'])->name('leader-cg.drier.month');
    Route::get('month-drier/{month}', [leaderCgOeeDrier::class, 'getDate'])->name('leader-cg.drier.date');
    Route::get('month-drier/{month}/list', [leaderCgOeeDrier::class, 'getDateList'])->name('leader-cg.drier.date.list');
    Route::post('oee-drier/okp', [leaderCgOeeDrier::class, 'getOkpDetail'])->name('leader-cg.drier.oee.okp');
    Route::post('oee-drier/list', [leaderCgOeeDrier::class, 'getOeeList'])->name('leader-cg.drier.oee.list');
    Route::post('oee-drier/store', [leaderCgOeeDrier::class, 'storeOee'])->name('leader-cg.drier.oee.store');
    Route::delete('oee-drier/destroy/{id}', [leaderCgOeeDrier::class, 'destroyOee'])->name('leader-cg.drier.oee.destroy');
});

//Prefix: PPIC
Route::group(['prefix' => 'ppic'], function(){
    Route::get('planorder', [ManagePlanOrderController::class, 'getPlanOrder'])->name('manage.planorder.index');
    Route::post('planorder', [ManagePlanOrderController::class, 'storePlanOrder'])->name('manage.planorder.store');
    Route::get('planorder/{id}', [ManagePlanOrderController::class, 'editPlanOrder'])->name('manage.planorder.edit');
    Route::put('planorder/{id}', [ManagePlanOrderController::class, 'updatePlanOrder'])->name('manage.planorder.update');
    Route::put('planorder/release/{id}', [ManagePlanOrderController::class, 'putReleasePlanOrder'])->name('manage.planorder.release');
    Route::delete('planorder/{id}', [ManagePlanOrderController::class, 'destroyPlanOrder'])->name('manage.planorder.destroy');
});
