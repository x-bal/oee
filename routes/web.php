<?php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\operator\OperatorController;
use App\Http\Controllers\operator\OperatorDrierController;
use App\Http\Controllers\leader\LeaderController;
use App\Http\Controllers\leader\LeaderDrierController;
use App\Http\Controllers\leader\ViewDowntimeController as LeaderViewDowntime;
use App\Http\Controllers\leader\ViewOeeController as LeaderDBOee;
use App\Http\Controllers\LineDashboardController as ViewLine;
use App\Http\Controllers\adminCg\OeeController as adminCgOee;
use App\Http\Controllers\adminCg\OeeDrierController as adminCgOeeDrier;
use App\Http\Controllers\adminCg\ViewOeeController as adminCgViewOee;
use App\Http\Controllers\adminCg\ViewDowntimeController as adminCgDowntime;
use App\Http\Controllers\DetailReportContoller;
use App\Http\Controllers\leaderCg\OeeController as leaderCgOee;
use App\Http\Controllers\leaderCg\OeeDrierController as leaderCgOeeDrier;
use App\Http\Controllers\leaderCg\ViewOeeController as leaderCgViewOee;
use App\Http\Controllers\leaderCg\ViewDowntimeController as leaderCgDowntime;
use App\Http\Controllers\QrLoginController;
use App\Http\Controllers\Opr\OprController;

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

//Not Auth User
Route::get('/', [AuthController::class, 'getIndex'])->name('auth.login');
Route::get('/line/{line_id}', [ViewLine::class, 'getIndex'])->name(
    'auth.line.view'
);
Route::post('/chart-poe', [AuthController::class, 'getChartPOE'])->name(
    'chart.poe'
);
Route::post('/chart-ur', [AuthController::class, 'getChartUR'])->name(
    'chart.urate'
);
Route::post('/login', [AuthController::class, 'postLogin'])->name(
    'auth.post.login'
);
Route::post('/shift-oee', [ViewLine::class, 'getOeeShift'])->name('chart.shift.oee');
Route::post('/line-oee', [ViewLine::class, 'getOeeLine'])->name('chart.line.oee');
Route::post('/line-output', [ViewLine::class, 'getlineOutput'])->name('chart.line.output');
//Qr Login
Route::group(['prefix' => 'qr'], function () {
    Route::get('/login', [QrLoginController::class, 'getIndex'])->name(
        'auth.qr.index'
    );
    Route::post('/login', [QrLoginController::class, 'postLogin'])->name(
        'auth.qr.login'
    );
});

//Logout
Route::get('/logout', [AuthController::class, 'getLogout'])->name(
    'auth.logout'
);

Route::get('dashboard/line/{line_id}', [ViewLine::class, 'getIndex'])->name(
    'dashboard.line.view'
);
Route::post('/postline', [DashboardController::class, 'setLineOrLeader'])->name(
    'dashboard.post.line'
);

//Profile User
Route::get('/profile', [UserController::class, 'getProfile'])->name(
    'user.profile'
);
Route::put('/profile/update-profile/{id}', [
    UserController::class,
    'updateProfile',
])->name('user.update.profile');
Route::put('/profile/update-password/{id}', [
    UserController::class,
    'updatePassword',
])->name('user.update.password');

//My Qr
Route::get('/viewqr', [UserController::class, 'getMyQr'])->name(
    'view.qr.index'
);
Route::get('/viewqr/change', [UserController::class, 'getChangeQr'])->name(
    'view.qr.change'
);
Route::get('oee/line', [ViewLine::class, 'getOeeChart'])->name('oee.data.line');

//Authenticated User
Route::group(['middleware' => 'auth'], function () {
    Route::get('dashboard', [DashboardController::class, 'getIndex'])->name(
        'dashboard.index'
    );
    //Prefix: Admin
    require __DIR__ . '/admin.php';

    //Prefix Operator
    Route::group(['prefix' => 'operator'], function () {
        //Operator Input OEE
        Route::get('month', [OperatorController::class, 'getMonth'])->name(
            'operator.month'
        );
        Route::get('month/{month}', [
            OperatorController::class,
            'getDate',
        ])->name('operator.date');
        Route::get('month/{month}/list', [
            OperatorController::class,
            'getDateList',
        ])->name('operator.date.list');
        Route::post('oee/okp', [
            OperatorController::class,
            'getOkpDetail',
        ])->name('operator.oee.okp');
        Route::post('oee/list', [
            OperatorController::class,
            'getOeeList',
        ])->name('operator.oee.list');
        Route::post('oee/store', [OperatorController::class, 'storeOee'])->name(
            'operator.oee.store'
        );
        Route::delete('oee/destroy/{id}', [
            OperatorController::class,
            'destroyOee',
        ])->name('operator.oee.destroy');

        //Operator Drier Input OEE
        Route::get('month-drier', [
            OperatorDrierController::class,
            'getMonth',
        ])->name('operator.drier.month');
        Route::get('month-drier/{month}', [
            OperatorDrierController::class,
            'getDate',
        ])->name('operator.drier.date');
        Route::post('oee-drier/okp', [
            OperatorDrierController::class,
            'getOkpDetail',
        ])->name('operator.drier.oee.okp');
        Route::post('oee-drier/list', [
            OperatorDrierController::class,
            'getOeeList',
        ])->name('operator.drier.oee.list');
        Route::post('oee-drier/store', [
            OperatorDrierController::class,
            'storeOee',
        ])->name('operator.drier.oee.store');
    });

    //Prefix: Leader
    Route::group(['prefix' => 'leader'], function () {
        //Leader: Input OEE
        Route::get('month', [LeaderController::class, 'getMonth'])->name(
            'leader.month'
        );
        Route::get('month/{month}', [LeaderController::class, 'getDate'])->name(
            'leader.date'
        );
        Route::get('month/{month}/list', [
            LeaderController::class,
            'getDateList',
        ])->name('leader.date.list');
        Route::post('oee/okp', [LeaderController::class, 'getOkpDetail'])->name(
            'leader.oee.okp'
        );
        Route::post('oee/list', [LeaderController::class, 'getOeeList'])->name(
            'leader.oee.list'
        );
        Route::post('oee/store', [LeaderController::class, 'storeOee'])->name(
            'leader.oee.store'
        );
        Route::delete('oee/destroy/{id}', [
            LeaderController::class,
            'destroyOee',
        ])->name('leader.oee.destroy');

        //Leader: DB OEE View
        Route::get('viewoee', [LeaderDBOee::class, 'getIndex'])->name(
            'leader.view.dboee'
        );
        Route::post('viewoee/list', [LeaderDBOee::class, 'listViewOee'])->name(
            'leader.list.dboee'
        );

        //View Downtime
        Route::get('viewdowntime', [
            LeaderViewDowntime::class,
            'getIndex',
        ])->name('leader.view.downtime');
        Route::post('viewdowntime/list', [
            LeaderViewDowntime::class,
            'postListDowntime',
        ])->name('leader.view.downtime.list');
    });

    //Prefix: Leader
    Route::group(['prefix' => 'leader-drier'], function () {
        //Leader: Input OEE
        Route::get('month', [LeaderDrierController::class, 'getMonth'])->name(
            'leaderDrier.month'
        );
        Route::get('month/{month}', [
            LeaderDrierController::class,
            'getDate',
        ])->name('leaderDrier.date');
        Route::get('month/{month}/list', [
            LeaderDrierController::class,
            'getDateList',
        ])->name('leaderDrier.date.list');
        Route::post('oee/okp', [
            LeaderDrierController::class,
            'getOkpDetail',
        ])->name('leaderDrier.oee.okp');
        Route::post('oee/list', [
            LeaderDrierController::class,
            'getOeeList',
        ])->name('leaderDrier.oee.list');
        Route::post('oee/store', [
            LeaderDrierController::class,
            'storeOee',
        ])->name('leaderDrier.oee.store');
        Route::delete('oee/destroy/{id}', [
            LeaderDrierController::class,
            'destroyOee',
        ])->name('leaderDrier.oee.destroy');

        //Leader: DB OEE View
        Route::get('viewoee', [LeaderDBOee::class, 'getIndex'])->name(
            'leader.view.dboee'
        );
        Route::post('viewoee/list', [LeaderDBOee::class, 'listViewOee'])->name(
            'leader.list.dboee'
        );
    });

    //Prefix: Admin CG
    Route::group(['prefix' => 'admin-cg'], function () {
        //Admin CG: Input OEE
        Route::get('month', [adminCgOee::class, 'getMonth'])->name(
            'admin-cg.month'
        );
        Route::get('month/{month}', [adminCgOee::class, 'getDate'])->name(
            'admin-cg.date'
        );
        Route::get('month/{month}/list', [
            adminCgOee::class,
            'getDateList',
        ])->name('admin-cg.date.list');
        Route::post('oee/okp', [adminCgOee::class, 'getOkpDetail'])->name(
            'admin-cg.oee.okp'
        );
        Route::post('oee/list', [adminCgOee::class, 'getOeeList'])->name(
            'admin-cg.oee.list'
        );
        Route::post('oee/store', [adminCgOee::class, 'storeOee'])->name(
            'admin-cg.oee.store'
        );
        Route::delete('oee/destroy/{id}', [
            adminCgOee::class,
            'destroyOee',
        ])->name('admin-cg.oee.destroy');

        //Admin CG: Input OEE Drier
        Route::get('month-drier', [adminCgOeeDrier::class, 'getMonth'])->name(
            'admin-cg.drier.month'
        );
        Route::get('month-drier/{month}', [
            adminCgOeeDrier::class,
            'getDate',
        ])->name('admin-cg.drier.date');
        Route::get('month-drier/{month}/list', [
            adminCgOeeDrier::class,
            'getDateList',
        ])->name('admin-cg.drier.date.list');
        Route::post('oee-drier/okp', [
            adminCgOeeDrier::class,
            'getOkpDetail',
        ])->name('admin-cg.drier.oee.okp');
        Route::post('oee-drier/list', [
            adminCgOeeDrier::class,
            'getOeeList',
        ])->name('admin-cg.drier.oee.list');
        Route::post('oee-drier/store', [
            adminCgOeeDrier::class,
            'storeOee',
        ])->name('admin-cg.drier.oee.store');
        Route::delete('oee-drier/destroy/{id}', [
            adminCgOeeDrier::class,
            'destroyOee',
        ])->name('admin-cg.drier.oee.destroy');

        //Admin CG: DB OEE View
        Route::get('viewoee', [adminCgViewOee::class, 'getIndex'])->name(
            'adminCg.view.dboee'
        );
        Route::post('viewoee/list', [
            adminCgViewOee::class,
            'listViewOee',
        ])->name('adminCg.list.dboee');

        //Admin CG: View Downtime Analysis
        Route::get('viewdowntime', [adminCgDowntime::class, 'getIndex'])->name(
            'adminCg.view.downtime'
        );
        Route::post('viewdowntime/list', [
            adminCgDowntime::class,
            'postListDowntime',
        ])->name('adminCg.view.downtime.list');
    });

    //Prefix: Leader CG
    Route::group(['prefix' => 'leader-cg'], function () {
        //Leader CG: Input OEE
        Route::get('month', [leaderCgOee::class, 'getMonth'])->name(
            'leaderCg.month'
        );
        Route::get('month/{month}', [leaderCgOee::class, 'getDate'])->name(
            'leaderCg.date'
        );
        Route::get('month/{month}/list', [
            leaderCgOee::class,
            'getDateList',
        ])->name('leaderCg.date.list');
        Route::post('oee/okp', [leaderCgOee::class, 'getOkpDetail'])->name(
            'leaderCg.oee.okp'
        );
        Route::post('oee/list', [leaderCgOee::class, 'getOeeList'])->name(
            'leaderCg.oee.list'
        );
        Route::post('oee/store', [leaderCgOee::class, 'storeOee'])->name(
            'leaderCg.oee.store'
        );
        Route::delete('oee/destroy/{id}', [
            leaderCgOee::class,
            'destroyOee',
        ])->name('leaderCg.oee.destroy');

        //Leader CG: DB OEE View
        Route::get('viewoee', [leaderCgViewOee::class, 'getIndex'])->name(
            'leaderCg.view.dboee'
        );
        Route::post('viewoee/list', [
            leaderCgViewOee::class,
            'listViewOee',
        ])->name('leaderCg.list.dboee');

        //Leader CG: View Downtime Analysis
        Route::get('viewdowntime', [leaderCgDowntime::class, 'getIndex'])->name(
            'leaderCg.view.downtime'
        );
        Route::post('viewdowntime/list', [
            leaderCgDowntime::class,
            'postListDowntime',
        ])->name('leaderCg.view.downtime.list');

        //Leader CG: Input OEE Drier
        Route::get('month-drier', [leaderCgOeeDrier::class, 'getMonth'])->name(
            'leader-cg.drier.month'
        );
        Route::get('month-drier/{month}', [
            leaderCgOeeDrier::class,
            'getDate',
        ])->name('leader-cg.drier.date');
        Route::get('month-drier/{month}/list', [
            leaderCgOeeDrier::class,
            'getDateList',
        ])->name('leader-cg.drier.date.list');
        Route::post('oee-drier/okp', [
            leaderCgOeeDrier::class,
            'getOkpDetail',
        ])->name('leader-cg.drier.oee.okp');
        Route::post('oee-drier/list', [
            leaderCgOeeDrier::class,
            'getOeeList',
        ])->name('leader-cg.drier.oee.list');
        Route::post('oee-drier/store', [
            leaderCgOeeDrier::class,
            'storeOee',
        ])->name('leader-cg.drier.oee.store');
        Route::delete('oee-drier/destroy/{id}', [
            leaderCgOeeDrier::class,
            'destroyOee',
        ])->name('leader-cg.drier.oee.destroy');
    });

    //Prefix: PPIC
    require __DIR__ . '/ppic.php';

    //Prefix: Checker
    require __DIR__ . '/checker.php';

    //Prefix: Opr
    Route::group(['prefix' => 'opr'], function () {
        Route::get('/', [OprController::class, 'getIndex'])->name(
            'input.opr.index'
        );
    });
    Route::get('/detailreport/production', [DetailReportContoller::class, 'production'])->name('detail-report.production');
});
