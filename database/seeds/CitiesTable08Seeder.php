<?php

use Illuminate\Database\Seeder;

class CitiesTable08Seeder extends Seeder
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
                'pref_id' => 8,
                'name' => '水戸市',
            ],
            [
                'pref_id' => 8,
                'name' => '日立市',
            ],
            [
                'pref_id' => 8,
                'name' => '土浦市',
            ],
            [
                'pref_id' => 8,
                'name' => '古河市',
            ],
            [
                'pref_id' => 8,
                'name' => '石岡市',
            ],
        ]);

        DB::statement('SET FOREIGN_KEY_CHECKS = 1;');
    }
}