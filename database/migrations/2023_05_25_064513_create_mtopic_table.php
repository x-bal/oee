<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMtopicTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('mtopic', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('machine_id');
            $table->unsignedInteger('broker_id');
            $table->timestamps();

            //Foreign Key to : Machine ID
            $table->foreign('machine_id')
                ->references('id')
                ->on('mmachines')
                ->cascadeOnUpdate()
                ->cascadeOnDelete();

            //Foreign Key to : Broker ID
            $table->foreign('broker_id')
                ->references('id')
                ->on('mbroker')
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
        Schema::dropIfExists('mtopic');
    }
}
