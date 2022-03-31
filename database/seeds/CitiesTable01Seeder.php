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
            //北海道
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

            //青森県
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
                'name' => '黒石市',
            ],
            [
                'pref_id' => 2,
                'name' => '五所川原市',
            ],

            //岩手県
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

            //宮城県
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

            //秋田県
            [
                'pref_id' => 5,
                'name' => '秋田市',
            ],
            [
                'pref_id' => 5,
                'name' => '能代市',
            ],
            [
                'pref_id' => 5,
                'name' => '横手市',
            ],
            [
                'pref_id' => 5,
                'name' => '大館市',
            ],
            [
                'pref_id' => 5,
                'name' => '男鹿市',
            ],

            //山形県
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

            //福島県
            [
                'pref_id' => 7,
                'name' => '福島市',
            ],
            [
                'pref_id' => 7,
                'name' => '会津若松市',
            ],
            [
                'pref_id' => 7,
                'name' => '郡山市',
            ],
            [
                'pref_id' => 7,
                'name' => 'いわき市',
            ],
            [
                'pref_id' => 7,
                'name' => '白河市',
            ],

            //茨城県
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

            //栃木県
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

            //群馬県
            [
                'pref_id' => 10,
                'name' => '前橋市',
            ],
            [
                'pref_id' => 10,
                'name' => '高崎市',
            ],
            [
                'pref_id' => 10,
                'name' => '桐生市',
            ],
            [
                'pref_id' => 10,
                'name' => '伊勢崎市',
            ],
            [
                'pref_id' => 10,
                'name' => '太田市',
            ],
        ]);

        DB::statement('SET FOREIGN_KEY_CHECKS = 1;');
    }
}
