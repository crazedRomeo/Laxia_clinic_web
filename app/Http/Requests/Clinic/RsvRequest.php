<?php

namespace App\Http\Requests\Clinic;

use Illuminate\Foundation\Http\FormRequest;
use App\Models\Reservation;

class RsvRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'reservations' => ['required', 'array'],
            'reservations.visit_date' => 'required|date',
            'reservations.start_time' => 'required|string',
            // 'reservations.end_time' => 'required|string',
            'reservations.doctor_id' => 'required|integer',
            'reservations.hope_treat' => 'required|integer',
            // 'reservations.menu_id' => 'required|integer|exists:menus,id',
        ];
    }

    /**
     * Get custom attributes for validator errors.
     *
     * @return array
     */
    public function attributes()
    {
        return [
            'reservations.visit_date' => '日にち',
            'reservations.start_time' => '診察時間',
            'reservations.end_time' => '診察時間',
            'reservations.doctor_id' => '医師',
            'reservations.hope_treat' => '予約内容',
            // 'reservations.menu_id' => '施術メニュー',
        ];
    }
}
