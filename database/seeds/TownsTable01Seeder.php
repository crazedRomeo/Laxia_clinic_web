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
            [
                'city_id' => 2,
                'name' => 'あいの里二条',
            ],
            [
                'city_id' => 2,
                'name' => 'あいの里三条',
            ],

            [
                'city_id' => 3,
                'name' => '丘珠町',
            ],
            [
                'city_id' => 3,
                'name' => '北四条東',
            ],
            [
                'city_id' => 3,
                'name' => '北五条東',
            ],

            [
                'city_id' => 4,
                'name' => '川北一条',
            ],
            [
                'city_id' => 4,
                'name' => '川北二条',
            ],
            [
                'city_id' => 4,
                'name' => '川北三条',
            ],

            [
                'city_id' => 5,
                'name' => '水車町',
            ],
            [
                'city_id' => 5,
                'name' => '月寒中央通',
            ],
            [
                'city_id' => 5,
                'name' => '月寒西一条',
            ],

            [
                'city_id' => 26,
                'name' => '青葉',
            ],
            [
                'city_id' => 26,
                'name' => '青柳',
            ],
            [
                'city_id' => 26,
                'name' => '浅虫',
            ],

            [
                'city_id' => 27,
                'name' => '青山',
            ],
            [
                'city_id' => 27,
                'name' => '悪戸',
            ],
            [
                'city_id' => 27,
                'name' => '石川',
            ],
            
            [
                'city_id' => 28,
                'name' => '青葉',
            ],
            [
                'city_id' => 28,
                'name' => '石堂',
            ],
            [
                'city_id' => 28,
                'name' => '一番町',
            ],

            [
                'city_id' => 29,
                'name' => 'あけぼの町',
            ],
            [
                'city_id' => 29,
                'name' => '旭町',
            ],
            [
                'city_id' => 29,
                'name' => '一番町',
            ],

            [
                'city_id' => 30,
                'name' => '旭町',
            ],
            [
                'city_id' => 30,
                'name' => '稲実',
            ],
            [
                'city_id' => 30,
                'name' => '岩木町',
            ],

            [
                'city_id' => 31,
                'name' => '青山',
            ],
            [
                'city_id' => 31,
                'name' => '浅岸',
            ],
            [
                'city_id' => 31,
                'name' => '愛宕町',
            ],

            [
                'city_id' => 32,
                'name' => '大通',
            ],
            [
                'city_id' => 32,
                'name' => '小山田',
            ],
            [
                'city_id' => 32,
                'name' => '栄町',
            ],

            [
                'city_id' => 33,
                'name' => '猪川町',
            ],
            [
                'city_id' => 33,
                'name' => '大船渡町',
            ],

            [
                'city_id' => 34,
                'name' => '東町',
            ],
            [
                'city_id' => 34,
                'name' => '石鳥谷町好地',
            ],
            [
                'city_id' => 34,
                'name' => '太田',
            ],

            [
                'city_id' => 35,
                'name' => '飯豊',
            ],
            [
                'city_id' => 35,
                'name' => '上野町',
            ],
            [
                'city_id' => 35,
                'name' => '大堤北',
            ],

            [
                'city_id' => 36,
                'name' => '旭ケ丘',
            ],
            [
                'city_id' => 36,
                'name' => '愛子中央',
            ],
            [
                'city_id' => 36,
                'name' => '愛子東',
            ],

            [
                'city_id' => 37,
                'name' => '銀杏町',
            ],
            [
                'city_id' => 37,
                'name' => '出花',
            ],
            [
                'city_id' => 37,
                'name' => '岩切',
            ],

            [
                'city_id' => 38,
                'name' => '荒井',
            ],
            [
                'city_id' => 38,
                'name' => '荒井東',
            ],
            [
                'city_id' => 38,
                'name' => '荒町',
            ],

            [
                'city_id' => 39,
                'name' => '秋保町長袋',
            ],
            [
                'city_id' => 39,
                'name' => 'あすと長町',
            ],
            [
                'city_id' => 39,
                'name' => '泉崎',
            ],

            [
                'city_id' => 40,
                'name' => '明石南',
            ],
            [
                'city_id' => 40,
                'name' => '旭丘堤',
            ],
            [
                'city_id' => 40,
                'name' => '泉ケ丘',
            ],

            [
                'city_id' => 41,
                'name' => '旭川南町',
            ],
            [
                'city_id' => 41,
                'name' => '新屋扇町',
            ],
            [
                'city_id' => 41,
                'name' => '新屋沖田町',
            ],

            [
                'city_id' => 42,
                'name' => '万町',
            ],
            [
                'city_id' => 42,
                'name' => '追分町',
            ],
            [
                'city_id' => 42,
                'name' => '大瀬儘下',
            ],

            [
                'city_id' => 43,
                'name' => '赤坂',
            ],
            [
                'city_id' => 43,
                'name' => '旭川',
            ],
            [
                'city_id' => 43,
                'name' => '駅前町',
            ],

            [
                'city_id' => 44,
                'name' => '赤館町',
            ],
            [
                'city_id' => 44,
                'name' => '有浦',
            ],
            [
                'city_id' => 44,
                'name' => '御成町',
            ],

            [
                'city_id' => 45,
                'name' => '船川港船川',
            ],
            [
                'city_id' => 45,
                'name' => '船越',
            ],

            [
                'city_id' => 46,
                'name' => '青柳',
            ],
            [
                'city_id' => 46,
                'name' => 'あかねケ丘',
            ],
            [
                'city_id' => 46,
                'name' => 'あこや町',
            ],

            [
                'city_id' => 47,
                'name' => '相生町',
            ],
            [
                'city_id' => 47,
                'name' => '大町',
            ],
            [
                'city_id' => 47,
                'name' => '春日',
            ],

            [
                'city_id' => 48,
                'name' => '泉町',
            ],
            [
                'city_id' => 48,
                'name' => '板井川',
            ],
            [
                'city_id' => 48,
                'name' => '上畑町',
            ],

            [
                'city_id' => 49,
                'name' => 'あきほ町',
            ],
            [
                'city_id' => 49,
                'name' => '駅東',
            ],
            [
                'city_id' => 49,
                'name' => '大宮',
            ],

            [
                'city_id' => 50,
                'name' => '泉田',
            ],
            [
                'city_id' => 50,
                'name' => '五日町',
            ],
            [
                'city_id' => 50,
                'name' => '大手町',
            ],

            [
                'city_id' => 51,
                'name' => '旭町',
            ],
            [
                'city_id' => 51,
                'name' => '荒井北',
            ],
            [
                'city_id' => 51,
                'name' => '飯坂町平野',
            ],

            [
                'city_id' => 52,
                'name' => '一箕町亀賀',
            ],
            [
                'city_id' => 52,
                'name' => '一箕町鶴賀',
            ],
            [
                'city_id' => 52,
                'name' => '一箕町松長',
            ],

            [
                'city_id' => 53,
                'name' => '安積',
            ],
            [
                'city_id' => 53,
                'name' => '安積荒井',
            ],
            [
                'city_id' => 53,
                'name' => '安積荒井本町',
            ],

            [
                'city_id' => 54,
                'name' => '東田町',
            ],
            [
                'city_id' => 54,
                'name' => '泉ケ丘',
            ],
            [
                'city_id' => 54,
                'name' => '泉玉露',
            ],

            [
                'city_id' => 55,
                'name' => '旭町',
            ],
            [
                'city_id' => 55,
                'name' => '泉田',
            ],
            [
                'city_id' => 55,
                'name' => '一番町',
            ],

            [
                'city_id' => 56,
                'name' => '青柳町',
            ],
            [
                'city_id' => 56,
                'name' => '赤塚',
            ],
            [
                'city_id' => 56,
                'name' => '石川町',
            ],

            [
                'city_id' => 57,
                'name' => '旭町',
            ],
            [
                'city_id' => 57,
                'name' => '鮎川町',
            ],
            [
                'city_id' => 57,
                'name' => '会瀬町',
            ],

            [
                'city_id' => 58,
                'name' => '天川',
            ],
            [
                'city_id' => 58,
                'name' => '荒川沖西',
            ],
            [
                'city_id' => 58,
                'name' => '荒川沖東',
            ],

            [
                'city_id' => 59,
                'name' => '旭町',
            ],
            [
                'city_id' => 59,
                'name' => '尾崎',
            ],
            [
                'city_id' => 59,
                'name' => '女沼',
            ],

            [
                'city_id' => 60,
                'name' => '旭台',
            ],
            [
                'city_id' => 60,
                'name' => '石岡',
            ],
            [
                'city_id' => 60,
                'name' => '大砂',
            ],

            [
                'city_id' => 61,
                'name' => '相野沢町',
            ],
            [
                'city_id' => 61,
                'name' => '旭',
            ],
            [
                'city_id' => 61,
                'name' => '飯田町',
            ],

            [
                'city_id' => 62,
                'name' => '相生町',
            ],
            [
                'city_id' => 62,
                'name' => '朝倉町',
            ],
            [
                'city_id' => 62,
                'name' => '伊勢町',
            ],

            [
                'city_id' => 63,
                'name' => '旭町',
            ],
            [
                'city_id' => 63,
                'name' => '泉町',
            ],
            [
                'city_id' => 63,
                'name' => '今泉町',
            ],

            [
                'city_id' => 64,
                'name' => '赤坂町',
            ],
            [
                'city_id' => 64,
                'name' => '浅沼町',
            ],
            [
                'city_id' => 64,
                'name' => '石塚町',
            ],

            [
                'city_id' => 65,
                'name' => '石橋町',
            ],
            [
                'city_id' => 65,
                'name' => '磯町',
            ],
            [
                'city_id' => 65,
                'name' => '今宮町',
            ],

            [
                'city_id' => 66,
                'name' => '青柳町',
            ],
            [
                'city_id' => 66,
                'name' => '朝倉町',
            ],
            [
                'city_id' => 66,
                'name' => '朝日町',
            ],

            [
                'city_id' => 67,
                'name' => '相生町',
            ],
            [
                'city_id' => 67,
                'name' => '旭町',
            ],
            [
                'city_id' => 67,
                'name' => '東町',
            ],

            [
                'city_id' => 68,
                'name' => '相生町',
            ],
            [
                'city_id' => 68,
                'name' => '稲荷町',
            ],
            [
                'city_id' => 68,
                'name' => '織姫町',
            ],

            [
                'city_id' => 69,
                'name' => '東町',
            ],
            [
                'city_id' => 69,
                'name' => '安堀町',
            ],
            [
                'city_id' => 69,
                'name' => '今泉町',
            ],

            [
                'city_id' => 70,
                'name' => '新井町',
            ],
            [
                'city_id' => 70,
                'name' => '飯田町',
            ],
            [
                'city_id' => 70,
                'name' => '飯塚町',
            ],
        ]);

        DB::statement('SET FOREIGN_KEY_CHECKS = 1;');
    }
}