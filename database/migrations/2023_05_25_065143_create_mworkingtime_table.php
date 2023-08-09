<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMworkingtimeTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('mworkingtime', function (Blueprint $table) {
            $table->increments('id');
            $table->string('txtshiftname', 32);
            $table->time('tmstart');
            $table->time('tmfinish');
            $table->boolean('intinterval');
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
        Schema::dropIfExists('mworkingtime');
    }
}
