<?php
namespace App\Enums\Reservation;

use App\Enums\BaseEnum;

final class Status extends BaseEnum
{
    const NOTSUPPORTED = 5;
    // const MISSEDCALL = 10;
    const INPROGRESS = 15;
    // const APPROVED = 20;
    // const VISITED = 25;
    // const HISTORY = 30;

    public static function asList(): array {
        return [
            self::NOTSUPPORTED => "未対応",
            // self::MISSEDCALL => "不在着信",
            self::INPROGRESS => "日時確定",
            // self::APPROVED => "予約完了",
            // self::VISITED => "予約完了",
            // self::HISTORY => "予約完了",
        ];
    }
}
