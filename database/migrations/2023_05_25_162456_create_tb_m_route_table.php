<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTbMRouteTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tb_m_route', function (Blueprint $table) {
            $table->increments('id');
            $table->string('route_code', 64);
            $table->string('from', 64);
            $table->string('to', 64);
            $table->string('zone', 64);
            $table->string('created_by', 128);
            $table->string('updated_by', 128);
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
        Schema::dropIfExists('tb_m_route');
    }
}
