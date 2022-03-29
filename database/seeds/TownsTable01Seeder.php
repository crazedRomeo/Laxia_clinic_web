<?php

use Illuminate\Database\Seeder;

class TownsTable01Seeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::statement('SET FOREIGN_KEY_CHECKS = 0;');
        DB::table('mtb_towns')->truncate();
        
        DB::table('mtb_towns')->insert([
            [
                'city_id' => 1,
                'name' => '旭ケ丘',
            ],
            [
                'city_id' => 1,
                'name' => '大通東',
            ],
            [
                'city_id' => 1,
                'name' => '大通西',
            ],
            [
                'city_id' => 2,
                'name' => 'あいの里一条',
            ],
        ]);

        DB::statement('SET FOREIGN_KEY_CHECKS = 1;');
    }
}