<?php

use Illuminate\Database\Seeder;

class CitiesTable06Seeder extends Seeder
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
                'pref_id' => 6,
                'name' => '山形市',
            ],
            [
                'pref_id' => 6,
                'name' => '米沢市',
            ],
            [
                'pref_id' => 6,
                'name' => '鶴岡市',
            ],
            [
                'pref_id' => 6,
                'name' => '酒田市',
            ],
            [
                'pref_id' => 6,
                'name' => '新庄市',
            ],
        ]);

        DB::statement('SET FOREIGN_KEY_CHECKS = 1;');
    }
}