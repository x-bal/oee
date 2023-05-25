<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMmachinesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('mmachines', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('line_id');
            $table->string('txtmachinename', 64);
            $table->string('txtpicture', 128)->default('default.png');
            $table->boolean('intbottleneck')->default(0);
            $table->timestamps();

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
        Schema::dropIfExists('mmachines');
    }
}
