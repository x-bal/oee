<?php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Ppic\ManagePlanOrderController;

Route::group(['prefix' => 'ppic'], function(){
    Route::get('/planorder', [ManagePlanOrderController::class, 'getPlanOrder'])->name('manage.planorder.index');
    Route::post('/planorder', [ManagePlanOrderController::class, 'storePlanOrder'])->name('manage.planorder.store');
    Route::get('/planorder/{id}', [ManagePlanOrderController::class, 'editPlanOrder'])->name('manage.planorder.edit');
    Route::put('/planorder/{id}', [ManagePlanOrderController::class, 'updatePlanOrder'])->name('manage.planorder.update');
    Route::put('/planorder/release/{id}', [ManagePlanOrderController::class, 'putReleasePlanOrder'])->name('manage.planorder.release');
    Route::delete('/planorder/{id}', [ManagePlanOrderController::class, 'destroyPlanOrder'])->name('manage.planorder.destroy');
});
