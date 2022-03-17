<?php
namespace App\Enums\Stuff;

use App\Enums\BaseEnum;

final class Job extends BaseEnum
{
    const DOCTOR = 1;
    const STUFF = 2;

    public static function asList(): array {
        return [
            self::DOCTOR => "医師",
            self::STUFF => "スタッフ",
        ];
    }
}
