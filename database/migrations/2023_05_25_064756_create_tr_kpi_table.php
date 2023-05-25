<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTrKpiTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tr_kpi', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('line_id');
            $table->unsignedInteger('kpi_id');
            $table->float('ar');
            $table->float('pr');
            $table->float('qr');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('tr_kpi');
    }
}
