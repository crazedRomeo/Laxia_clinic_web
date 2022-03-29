<?php

use Illuminate\Database\Seeder;

class CitiesTable03Seeder extends Seeder
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
                'pref_id' => 3,
                'name' => '盛岡市',
            ],
            [
                'pref_id' => 3,
                'name' => '宮古市',
            ],
            [
                'pref_id' => 3,
                'name' => '大船渡市',
            ],
            [
                'pref_id' => 3,
                'name' => '花巻市',
            ],
            [
                'pref_id' => 3,
                'name' => '北上市',
            ],
        ]);

        DB::statement('SET FOREIGN_KEY_CHECKS = 1;');
    }
}