<?php

use Illuminate\Database\Seeder;

class CitiesTable02Seeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::statement('SET FOREIGN_KEY_CHECKS = 0;');
        DB::table('mtb_cities')->truncate();
        
        DB::table('mtb_cities')->insert([
            [
                'pref_id' => 2,
                'name' => '青森市',
            ],
            [
                'pref_id' => 2,
                'name' => '弘前市',
            ],
            [
                'pref_id' => 2,
                'name' => '八戸市',
            ],
            [
                'pref_id' => 2,
                'name' => '八戸市',
            ],
            [
                'pref_id' => 2,
                'name' => '五所川原市',
            ],
        ]);

        DB::statement('SET FOREIGN_KEY_CHECKS = 1;');
    }
}