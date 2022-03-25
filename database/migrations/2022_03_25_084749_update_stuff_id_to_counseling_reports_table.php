<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class UpdateStuffIdToCounselingReportsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('counseling_reports', function (Blueprint $table) {
            $table->dropColumn('stuff_id');
            $table->bigInteger('doctor_id')->comment('医師ID')->nullable()->unsigned()->after('clinic_id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('counseling_reports', function (Blueprint $table) {
            //
        });
    }
}
