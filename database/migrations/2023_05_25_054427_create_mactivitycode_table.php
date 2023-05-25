<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMactivitycodeTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('mactivitycode', function (Blueprint $table) {
            $table->id();
            $table->unsignedInteger('line_id');
            $table->string('txtactivitycode', 16);
            $table->string('txtcategory', 100);
            $table->string('txtactivityname', 128);
            $table->string('txtactivityitem', 128);
            $table->string('txtdescription', 255);
            $table->timestamps();

            //Foreign Key to : Line ID
            $table
                ->foreign('line_id')
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
        Schema::dropIfExists('mactivitycode');
    }
}
