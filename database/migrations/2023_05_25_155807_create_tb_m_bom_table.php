<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTbMBomTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tb_m_bom', function (Blueprint $table) {
            $table->increments('id');
            $table->string('part_number', 64);
            $table->integer('manufacturing_qty');
            $table->string('unit');
            $table->string('part_child');
            $table->integer('part_child_qty');
            $table->string('unit_child');
            $table->integer('pos_id');
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
        Schema::dropIfExists('tb_m_bom');
    }
}
