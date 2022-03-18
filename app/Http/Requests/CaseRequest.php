<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use App\Models\TreatCase;

class CaseRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        if ($this->route('id')) {
            $case = TreatCase::find($this->route('id'));
            return $case && $this->user()->can('update', $case);
        }
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
            'cases' => ['required', 'array'],
            'cases.name' => 'required',
            'cases.patient_age' => 'required|integer',
            'cases.patient_gender' => 'required',
            'cases.case_description' => 'required',
            'cases.doctor_opinion' => 'nullable',
            'cases.treat_risk' => 'required',
            'categories' => ['required', 'array'],
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
            'cases.menu_id' => 'メニュー名',
            'cases.name' => 'タイトル',
            'cases.patient_age' => '施術者の年齢',
            'cases.patient_gender' => '施術者の性別',
            'cases.case_description' => '施術者の解説',
            'cases.doctor_opinion' => '施術者の解説',
            'cases.treat_risk' => '施術者の解説',
            'categories' => 'カテゴリー',
        ];
    }
}
