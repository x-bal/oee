<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMbrokerTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('mbroker', function (Blueprint $table) {
            $table->increments('id');
            $table->string('txthost', 128);
            $table->char('intport', 8);
            $table->char('intwsport', 8)->nullable();
            $table->string('txtusername', 64)->nullable();
            $table->string('txtpassword', 64)->nullable();
            $table->boolean('intactive')->default(0);
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
        Schema::dropIfExists('mbroker');
    }
}
