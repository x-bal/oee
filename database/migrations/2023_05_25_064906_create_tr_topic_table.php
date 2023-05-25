<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTrTopicTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tr_topic', function (Blueprint $table) {
            $table->unsignedInteger('topic_id');
            $table->unsignedBigInteger('activity_id');
            $table->string('txtname', 64);
            $table->string('txttopic', 64);
            $table->timestamps();

            //Foreign Key to : Topic ID
            $table->foreign('topic_id')
                ->references('id')
                ->on('mtopic')
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
        Schema::dropIfExists('tr_topic');
    }
}
