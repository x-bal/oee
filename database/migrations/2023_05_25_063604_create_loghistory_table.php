<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateLoghistoryTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('loghistory', function (Blueprint $table) {
            $table->id();
            $table->unsignedInteger('machine_id');
            $table->string('name', 32);
            $table->integer('status');
            $table->unsignedBigInteger('activity_id')->default(0);
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
        Schema::dropIfExists('loghistory');
    }
}
