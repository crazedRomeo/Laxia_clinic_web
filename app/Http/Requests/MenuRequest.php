<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class MenuRequest extends FormRequest
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
            'menus' => ['required', 'array'],
            'menus.name' => 'required|string|max:255',
            'categories' => ['required', 'array'],
            // 'menus.category_id' => 'required|integer|exists:mtb_part_categories,id',
            'menus.price' => 'required|integer',
            'menus.description' => 'required',
            'menus.risk' => 'required',
            'menus.guarantee' => 'required',
            'menus.treat_time' => 'nullable|integer',
            'menus.required_time' => 'nullable|integer',
            'menus.masui' => 'nullable|integer',
            'menus.hospital_visit' => 'nullable|integer',
            'menus.hare' => 'nullable|integer',
            'menus.pain' => 'nullable|integer',
            'menus.bleeding' => 'nullable|integer',
            'menus.hospital_need' => 'nullable|integer',
            'menus.basshi' => 'nullable|integer',
            'menus.makeup' => 'nullable|integer',
            'menus.shower' => 'nullable|integer',
            'menus.massage' => 'nullable|integer',
            'menus.sport_impossible' => 'nullable|integer',
            'menus.status' => 'required|boolean'
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
            'menus.name' => 'メニュー名',
            'categories' => 'カテゴリー',
            // 'menus.category_id' => 'カテゴリー',
            'menus.categories' => 'カテゴリー',
            'menus.price' => '料金',
            'menus.description' => 'メニューの説明',
            'menus.risk' => '副作用・リスク',
            'menus.guarantee' => '施術の保証',
            'menus.treat_time' => '施術の時間',
            'menus.required_time' => '所要時間',
            'menus.masui' => '麻酔',
            'menus.hospital_visit' => '施術後の通院',
            'menus.hare' => '腫れ',
            'menus.pain' => '痛み',
            'menus.bleeding' => '内出血',
            'menus.hospital_need' => '入院の必要性',
            'menus.basshi' => '抜糸',
            'menus.makeup' => 'メイク/洗顔',
            'menus.shower' => 'シャワー/洗髪/入浴',
            'menus.massage' => '施術部のマッサー',
            'menus.sport_impossible' => '激しいスポーツ',
        ];
    }
}
