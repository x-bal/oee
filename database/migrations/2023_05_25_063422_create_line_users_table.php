<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateLineUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('line_users', function (Blueprint $table) {
            $table->unsignedBigInteger('user_id');
            $table->unsignedInteger('line_id');
            $table->timestamps();

            //Foreign Key to : User ID
            $table->foreign('user_id')
                ->references('id')
                ->on('musers')
                ->cascadeOnUpdate()
                ->cascadeOnDelete();
                
            //Foreign Key to : Line ID
            $table->foreign('line_id')
                ->references('id')
                ->on('mline')
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
        Schema::dropIfExists('line_users');
    }
}
