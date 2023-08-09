<?php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Ppic\ManagePlanOrderController;

Route::group(['prefix' => 'ppic'], function(){
    Route::name('manage.')->group(function(){
        Route::resource('planorder', ManagePlanOrderController::class)->only(['index', 'store', 'edit', 'update', 'destroy']);
        Route::put('/planorder/release/{id}', [ManagePlanOrderController::class, 'putReleasePlanOrder'])->name('planorder.release');
    });
});
