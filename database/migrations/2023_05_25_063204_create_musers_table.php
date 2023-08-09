<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMusersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('musers', function (Blueprint $table) {
            $table->id();
            $table->unsignedInteger('line_id');
            $table->unsignedInteger('level_id');
            $table->string('txtname', 128);
            $table->string('txtusername', 64);
            $table->string('password', 255);
            $table->char('txtinitial', 8);
            $table->string('txtphoto', 191);
            $table->timestamps();

            //Foreign Key to : Level ID
            $table->foreign('level_id')
                ->references('id')
                ->on('mlevels')
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
        Schema::dropIfExists('musers');
    }
}
