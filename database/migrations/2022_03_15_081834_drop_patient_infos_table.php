<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class DropPatientInfosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::disableForeignKeyConstraints();

        Schema::dropIfExists('patient_infos');

        Schema::enableForeignKeyConstraints();
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::create('patient_infos', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('patient_id')->unsigned();
            $table->foreign('patient_id')->references('id')->on('patients')->onDelete('cascade');
            $table->string('name01')->nullable();
            $table->string('name02')->nullable();
            $table->string('kana01')->nullable();
            $table->string('kana02')->nullable();
            $table->date('birthday')->nullable();
            $table->string('gender')->nullable();
            $table->string('phone_number')->nullable();
            $table->timestamps();
        });
    }
}
