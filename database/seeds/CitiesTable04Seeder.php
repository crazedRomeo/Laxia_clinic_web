<?php

use Illuminate\Database\Seeder;

class CitiesTable04Seeder extends Seeder
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
                'pref_id' => 4,
                'name' => '仙台市青葉区',
            ],
            [
                'pref_id' => 4,
                'name' => '仙台市宮城野区',
            ],
            [
                'pref_id' => 4,
                'name' => '仙台市若林区',
            ],
            [
                'pref_id' => 4,
                'name' => '仙台市太白区',
            ],
            [
                'pref_id' => 4,
                'name' => '仙台市泉区',
            ],
        ]);

        DB::statement('SET FOREIGN_KEY_CHECKS = 1;');
    }
}