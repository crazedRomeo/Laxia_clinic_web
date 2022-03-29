<?php

use Illuminate\Database\Seeder;

class CitiesTable01Seeder extends Seeder
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
                'pref_id' => 1,
                'name' => '札幌市中央区',
            ],
            [
                'pref_id' => 1,
                'name' => '札幌市北区',
            ],
            [
                'pref_id' => 1,
                'name' => '札幌市東区',
            ],
            [
                'pref_id' => 1,
                'name' => '札幌市白石区',
            ],
            [
                'pref_id' => 1,
                'name' => '札幌市豊平区',
            ],
            [
                'pref_id' => 1,
                'name' => '札幌市南区',
            ],
            [
                'pref_id' => 1,
                'name' => '札幌市西区',
            ],
            [
                'pref_id' => 1,
                'name' => '札幌市厚別区',
            ],
            [
                'pref_id' => 1,
                'name' => '札幌市手稲区',
            ],
            [
                'pref_id' => 1,
                'name' => '札幌市清田区',
            ],
            [
                'pref_id' => 1,
                'name' => '函館市',
            ],
            [
                'pref_id' => 1,
                'name' => '小樽市',
            ],
            [
                'pref_id' => 1,
                'name' => '旭川市',
            ],
            [
                'pref_id' => 1,
                'name' => '室蘭市',
            ],
            [
                'pref_id' => 1,
                'name' => '釧路市',
            ],
            [
                'pref_id' => 1,
                'name' => '帯広市',
            ],
            [
                'pref_id' => 1,
                'name' => '北見市',
            ],
            [
                'pref_id' => 1,
                'name' => '夕張市',
            ],
            [
                'pref_id' => 1,
                'name' => '岩見沢市',
            ],
            [
                'pref_id' => 1,
                'name' => '網走市',
            ],
            [
                'pref_id' => 1,
                'name' => '留萌市',
            ],
            [
                'pref_id' => 1,
                'name' => '苫小牧市',
            ],
            [
                'pref_id' => 1,
                'name' => '稚内市',
            ],
            [
                'pref_id' => 1,
                'name' => '美唄市',
            ],
            [
                'pref_id' => 1,
                'name' => '芦別市',
            ],

        ]);

        DB::statement('SET FOREIGN_KEY_CHECKS = 1;');
    }
}
