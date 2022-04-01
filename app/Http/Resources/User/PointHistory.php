<?php

namespace App\Http\Resources\User;

use App\Enums\Common\PointType;
use Illuminate\Http\Resources\Json\JsonResource;
use App\Models\Clinic;

class PointHistory extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array
     */
    public function toArray($request)
    {
        $title = '';
        switch ($this->type) {
            case PointType::USER_NEW_REGISTERED:
                $title = 'ログイン特典ポイント';
                break;
            case PointType::RESERVATION_REQUESTED:
                $clinic = Clinic::find($this->type_id);
                if ($clinic) {
                    $title = "{$clinic->name}で利用";
                }
                break;
            case PointType::RESERVATION_FINISHED:
                $clinic = Clinic::find($this->type_id);
                if ($clinic) {
                    $title = "{$clinic->name}で予約";
                }
                break;
            default:
        }
        return [
            'id' => $this->id,
            'patient_id' => $this->patient_id,
            'title' => $title,
            'use_point' => $this->use_point,
            'type' => $this->type,
            'type_id' => $this->type_id,
            'created_at' => $this->created_at,
        ];
    }
}
