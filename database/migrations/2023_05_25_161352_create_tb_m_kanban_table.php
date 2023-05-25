<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTbMKanbanTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tb_m_kanban', function (Blueprint $table) {
            $table->increments('id');
            $table->string('epc', 64);
            $table->string('kanban_no', 64);
            $table->string('kanban_type', 64);
            $table->string('sap_id', 64);
            $table->string('part_number', 64);
            $table->string('part_name', 64);
            $table->integer('qty_kanban');
            $table->string('packaging_type', 64);
            $table->string('from_loc', 64);
            $table->string('to_loc', 64);
            $table->string('zone', 64);
            $table->string('customer_id', 64);
            $table->string('image', 64);
            $table->string('spec_1', 64);
            $table->string('spec_2', 64);
            $table->string('key_point', 64);
            $table->string('rev', 64);
            $table->string('rev_item', 64);
            $table->string('admin', 64);
            $table->dateTime('valid_from');
            $table->dateTime('valid_to');
            $table->integer('status');
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
        Schema::dropIfExists('tb_m_kanban');
    }
}
