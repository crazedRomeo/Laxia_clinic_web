<?php
namespace App\Enums\Common;

use App\Enums\BaseEnum;

final class PointType extends BaseEnum
{
    const RESERVATION_REQUESTED = "reservation_requested";
    const USER_NEW_REGISTERED = "user_new_registered";
    const RESERVATION_FINISHED = "reservation_finished";
    const USER_INVITATION = "user_invitation";

    public static function asList(): array {
        return [
            self::RESERVATION_REQUESTED => "reservation_requested",
            self::USER_NEW_REGISTERED => "user_new_registered",
            self::RESERVATION_FINISHED => "reservation_finished",
            self::USER_INVITATION => "user_invitation",
        ];
    }
}
