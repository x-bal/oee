<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateLevelAccessTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('level_access', function (Blueprint $table) {
            $table->unsignedInteger('level_id');
            $table->unsignedInteger('menu_id');
            $table->timestamps();

            //Foreign Key to : Level ID
            $table->foreign('level_id')
                ->references('id')
                ->on('mlevels')
                ->cascadeOnUpdate()
                ->cascadeOnDelete();

            //Foreign Key to : Menu ID
            $table->foreign('menu_id')
                ->references('id')
                ->on('menu')
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
        Schema::dropIfExists('level_access');
    }
}
