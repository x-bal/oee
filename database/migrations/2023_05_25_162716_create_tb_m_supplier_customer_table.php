<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTbMSupplierCustomerTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tb_m_supplier_customer', function (Blueprint $table) {
            $table->increments('id');
            $table->string('customer_supplier_code', 64);
            $table->string('cs_name', 64);
            $table->string('cs_type', 64);
            $table->string('address', 64);
            $table->string('phone', 64);
            $table->string('pic', 64);
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
        Schema::dropIfExists('tb_m_supplier_customer');
    }
}
