<?php
namespace App\Services\User;

use Illuminate\Support\Arr;
use App\Models\TreatCase;
use DB;
use Auth;
use Throwable;

/**
 * Class CaseService
 * @package App\Services
 */
class CaseService
{
  public function paginate($search)
  {
    $per_page = isset($search['per_page']) ? $search['per_page'] : 20;
    $query = TreatCase::query()
      ->with(['clinic', 'categories', 'menus', 'doctor', 'images']);

    if (isset($search['q'])) {
      $query->where('name', 'LIKE', "%{$search['q']}%");
    }

    if (isset($search['clinic_id'])) {
      $query->where('clinic_id', $search['clinic_id']);
    }

    if (isset($search['doctor_id']) && $search['doctor_id'] != '-1') {
      $query->where('doctor_id', $search['doctor_id']);
    }

    // if (isset($search['category_id']) && $search['category_id'] != '-1') {
    //   $query->where('category_id', $search['category_id']);
    // }

    $query->orderby('created_at', 'desc');
    return $query->paginate($per_page);
  }

  public function get($id)
  {
    return TreatCase::findOrFail($id);
  }

  public function store($attributes, $addtional = [])
  {
    $caseAttrs = Arr::get($attributes, 'cases');

    $data = array_merge($caseAttrs, $addtional);
    $case = TreatCase::create($data);

    return $case;
  }

  public function update($attributes, $where)
  {
    $caseAttrs = Arr::get($attributes, 'cases');
    $case = TreatCase::where($where)
      ->firstOrFail();
    $case->fill($caseAttrs);
    $case->save();

    return $case;
  }
}
