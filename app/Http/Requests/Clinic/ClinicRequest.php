<?php

namespace App\Http\Requests\Clinic;

use Illuminate\Foundation\Http\FormRequest;

class ClinicRequest extends FormRequest
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
            'clinic' => ['required', 'array'],
            'clinic.name' => 'required|string',
            'clinic.pref_id' => 'nullable|integer|exists:mtb_prefs,id',
            'clinic.city_id' => 'nullable|integer|exists:mtb_cities,id',
            'clinic.town_id' => 'nullable|integer|exists:mtb_towns,id',
            'clinic.addr02' => 'nullable|string|max:255',
            'clinic.nearest_station' => 'nullable|string|max:255',
            'clinic.site' => 'nullable|string|max:255',
            'clinic.access' => 'nullable|string|max:255',
            'clinic.phone_number' => 'nullable|string|max:255',
            'clinic.credit_card' => 'nullable|string|max:255',
            'clinic.parking' => 'nullable|string|max:255',
            'clinic.photo' => 'nullable|string|max:255',
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
            'clinic.name' => 'クリニック名',
            'clinic.pref_id' => '都道府県',
            'clinic.city_id' => '住所',
            'clinic.town_id' => '住所',
            'clinic.addr02' => '住所',
            'clinic.nearest_station' => '最寄駅',
            'clinic.site' => '公式サイト',
            'clinic.access' => 'アクセス',
            'clinic.phone_number' => '電話番号',
            'clinic.credit_card' => 'クレジットカード',
            'clinic.parking' => '駐車場',
            'clinic.photo' => '',
        ];
    }
}
