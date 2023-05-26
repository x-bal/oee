<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTblTrBreakdownTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tbl_tr_breakdown', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('pos_id');
            $table->unsignedInteger('machine_id');
            $table->unsignedInteger('breakdown_id');
            $table->dateTime('breakdown_start');
            $table->dateTime('breakdown_finish');
            $table->string('created_by', 64);
            $table->string('updated_by', 64);
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
        Schema::dropIfExists('tbl_tr_breakdown');
    }
}
