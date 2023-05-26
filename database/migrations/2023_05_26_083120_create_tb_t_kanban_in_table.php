<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTbTKanbanInTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tb_t_kanban_in', function (Blueprint $table) {
            $table->increments('id');
            $table->string('sap_id', 128);
            $table->unsignedInteger('pos_id');
            $table->unsignedInteger('user_id');
            $table->string('epc', 64);
            $table->string('kanban_id', 64);
            $table->string('kanban_type', 64);
            $table->string('part_number', 64);
            $table->string('qty', 64);
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
        Schema::dropIfExists('tb_t_kanban_in');
    }
}
