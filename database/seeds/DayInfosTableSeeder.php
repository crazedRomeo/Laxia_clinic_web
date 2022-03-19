<?php

use Illuminate\Database\Seeder;

class DayInfosTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::statement('SET FOREIGN_KEY_CHECKS = 0;');
        DB::table('day_infos')->truncate();

        DB::table('day_infos')->insert([
            [
                'name' => '月曜日',
                'order' => 1
            ],
            [
                'name' => '火曜日',
                'order' => 2
            ],
            [
                'name' => '水曜日',
                'order' => 3
            ],
            [
                'name' => '木曜日',
                'order' => 4
            ],
            [
                'name' => '金曜日',
                'order' => 5
            ],
            [
                'name' => '土曜日',
                'order' => 6
            ],
            [
                'name' => '日曜日',
                'order' => 7
            ],
            [
                'name' => '祝日',
                'order' => 8
            ],
        ]);

        DB::statement('SET FOREIGN_KEY_CHECKS = 1;');
    }
}
