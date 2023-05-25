<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTbMItemPartsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tb_m_item_parts', function (Blueprint $table) {
            $table->increments('id');
            $table->string('sap_id', 64);
            $table->string('part_number', 64);
            $table->string('part_name', 64);
            $table->string('part_category', 64);
            $table->string('location_code', 64);
            $table->string('model', 64);
            $table->string('supplier_customer_code', 64);
            $table->integer('min_qty');
            $table->integer('max_qty');
            $table->integer('standard');
            $table->string('packaging_name', 64);
            $table->integer('lot_qty');
            $table->string('unit', 64);
            $table->boolean('common_item');
            $table->integer('ct');
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
        Schema::dropIfExists('tb_m_item_parts');
    }
}
