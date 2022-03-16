<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class UpdateAllColumnsToReservationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('reservations', function (Blueprint $table) {
            $table->dropForeign('reservations_patient_info_id_foreign');
            $table->dropForeign('reservations_stuff_id_foreign');
            $table->dropForeign('reservations_rsv_content_id_foreign');
            $table->dropForeign('reservations_menu_id_foreign');

            $table->renameColumn('patient_info_id', 'patient_id');
            $table->renameColumn('stuff_id', 'doctor_id');
            
            $table->dropColumn(['rsv_content_id', 'menu_id', 'source']);

            $table->smallInteger('hope_treat')->change();

            $table->text('note')->comment('希望・相談')->change();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('reservations', function (Blueprint $table) {
            //
        });
    }
}
