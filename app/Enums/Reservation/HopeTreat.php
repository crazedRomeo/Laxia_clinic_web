<?php
namespace App\Enums\Reservation;

use App\Enums\BaseEnum;

final class HopeTreat extends BaseEnum
{
    const COUNSELING = 5;
    const TREATMENT = 10;
    // const TEST = 15;
    const TREATMENTCOUNSELING = 20;

    public static function asList(): array {
        return [
            self::COUNSELING => "カウンセリングのみ",
            self::TREATMENT => "施術",
            // self::TEST => "術後検査",
            self::TREATMENTCOUNSELING => "カウンセリング・施術",
        ];
    }
}
