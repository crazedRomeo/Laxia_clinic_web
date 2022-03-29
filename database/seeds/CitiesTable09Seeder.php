<?php

use Illuminate\Database\Seeder;

class CitiesTable09Seeder extends Seeder
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
                'pref_id' => 9,
                'name' => '宇都宮市',
            ],
            [
                'pref_id' => 9,
                'name' => '足利市',
            ],
            [
                'pref_id' => 9,
                'name' => '栃木市',
            ],
            [
                'pref_id' => 9,
                'name' => '佐野市',
            ],
            [
                'pref_id' => 9,
                'name' => '鹿沼市',
            ],
        ]);

        DB::statement('SET FOREIGN_KEY_CHECKS = 1;');
    }
}