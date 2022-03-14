<?php
namespace App\Enums\Menu;

use App\Enums\BaseEnum;

final class RequiredTime extends BaseEnum
{
    const REQUIREDTIME01 = 5;
    const REQUIREDTIME02 = 10;
    const REQUIREDTIME03 = 15;
    const REQUIREDTIME04 = 20;
    const REQUIREDTIME05 = 25;
    const REQUIREDTIME06 = 30;
    const REQUIREDTIME07 = 35;
    const REQUIREDTIME08 = 40;
    const REQUIREDTIME09 = 45;
    const REQUIREDTIME10 = 50;
    const REQUIREDTIME11 = 55;
    const REQUIREDTIME12 = 60;
    const REQUIREDTIME13 = 90;
    const REQUIREDTIME14 = 120;
    const REQUIREDTIME15 = 180;

    public static function asList(): array {
        return [
            self::REQUIREDTIME01 => "5分",
            self::REQUIREDTIME02 => "10分",
            self::REQUIREDTIME03 => "15分",
            self::REQUIREDTIME04 => "20分",
            self::REQUIREDTIME05 => "25分",
            self::REQUIREDTIME06 => "30分",
            self::REQUIREDTIME07 => "35分",
            self::REQUIREDTIME08 => "40分",
            self::REQUIREDTIME09 => "45分",
            self::REQUIREDTIME10 => "50分",
            self::REQUIREDTIME11 => "55分",
            self::REQUIREDTIME12 => "60分",
            self::REQUIREDTIME13 => "90分",
            self::REQUIREDTIME14 => "120分",
            self::REQUIREDTIME15 => "180分",
        ];
    }
}
