<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMdailyactivitiesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('mdailyactivities', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('line_id');
            $table->unsignedBigInteger('activity_id');
            $table->time('tmstart');
            $table->time('tmfinish');
            $table->timestamps();

            //Foreign Key to : Line ID
            $table->foreign('line_id')
                ->references('id')
                ->on('mline')
                ->cascadeOnUpdate()
                ->cascadeOnDelete();

            //Foreign Key to : Activity ID
            $table->foreign('activity_id')
                ->references('id')
                ->on('mactivitycode')
                ->cascadeOnUpdate()
                ->cascadeOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('mdailyactivities');
    }
}
