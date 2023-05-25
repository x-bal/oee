<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTbMPosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tb_m_pos', function (Blueprint $table) {
            $table->increments('id');
            $table->string('pos_code', 7);
            $table->string('description', 64);
            $table->string('type_scan_1', 64);
            $table->string('type_scan_2', 64);
            $table->string('type', 128);
            $table->string('created_by', 64);
            $table->string('updated_by', 64);
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
        Schema::dropIfExists('tb_m_pos');
    }
}
