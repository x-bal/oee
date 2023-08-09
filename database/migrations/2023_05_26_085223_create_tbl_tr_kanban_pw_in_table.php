<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTblTrKanbanPwInTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tbl_tr_kanban_pw_in', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('pos_id');
            $table->unsignedInteger('user_id');
            $table->string('epc_no', 64);
            $table->integer('qty');
            $table->boolean('is_finish');
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
        Schema::dropIfExists('tbl_tr_kanban_pw_in');
    }
}
