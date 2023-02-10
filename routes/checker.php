<?php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Opr\OprController;

Route::group(['prefix' => 'checker'], function(){
    Route::get('/details', [OprController::class, 'getDetails'])->name('checker.details.get');
    Route::get('/oee/{id}', [OprController::class, 'getOeeDetail'])->name('checker.detail.oee');
    Route::get('/oee/list/activity', [OprController::class, 'getListActivity'])->name('checker.list.activity');
    Route::put('/oee/{id}', [OprController::class, 'putInputOee'])->name('checker.oee.update');
    Route::put('/oee/finish/{id}', [OprController::class, 'putFinishOrder'])->name('checker.planorder.finish');
});
