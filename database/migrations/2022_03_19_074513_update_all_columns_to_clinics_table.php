<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class UpdateAllColumnsToClinicsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('clinics', function (Blueprint $table) {
            $table->dropColumn(['addr01', 'department', 'net_reservation', 'working_time', 'holidays', 'company_title', 'company_profile', 'ave_diaries_rate']);

            $table->smallInteger('town_id')->unsigned()->nullable()->after('pref_id');
            $table->smallInteger('city_id')->unsigned()->nullable()->after('pref_id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('clinics', function (Blueprint $table) {
            //
        });
    }
}
