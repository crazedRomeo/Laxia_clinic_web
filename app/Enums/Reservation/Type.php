<?php
namespace App\Enums\Reservation;

use App\Enums\BaseEnum;

final class Type extends BaseEnum
{
    const CHAT = 5;
    const PHONE = 10;

    public static function asList(): array {
        return [
            self::CHAT => "チャット",
            self::PHONE => "電話予約",
        ];
    }
}
