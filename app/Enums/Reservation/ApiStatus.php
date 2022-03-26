<?php
namespace App\Enums\Reservation;

use App\Enums\BaseEnum;

final class ApiStatus extends BaseEnum
{
    const ADJUSTING = 1;
    const RESERVED = 2;
    const VISITED = 3;
    const HISTORY = 4;

    public static function asList(): array {
        return [
            self::ADJUSTING => "調整中",
            self::RESERVED => "予約済",
            self::VISITED => "来院済",
            self::HISTORY => "施術履歴",
        ];
    }
}
