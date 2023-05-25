<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMassignLineTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('massign_line', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('line_id');
            $table->unsignedBigInteger('user_id');
            $table->timestamps();

            //Foreign Key to : Line ID
            $table->foreign('line_id')
                ->references('id')
                ->on('mline')
                ->cascadeOnUpdate()
                ->cascadeOnDelete();

            //Foreign Key to : User ID
            $table->foreign('user_id')
                ->references('id')
                ->on('musers')
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
        Schema::dropIfExists('massign_line');
    }
}
