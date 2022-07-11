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
      ->with(['clinic', 'categories', 'menus', 'doctor', 'images'])->withCount('likers');

    if (isset($search['q'])) {
      $query->where('name', 'LIKE', "%{$search['q']}%");
    }

    if (isset($search['clinic_id'])) {
      $query->where('clinic_id', $search['clinic_id']);
    }

    if (isset($search['doctor_id']) && $search['doctor_id'] != '-1') {
      $query->where('doctor_id', $search['doctor_id']);
    }
    if (isset($search['category_id']) && $search['category_id'] != '-1') {
        // $query->where('category_id', $search['category_id']);
        $query->join('case_categories as cc', 'cases.id', '=', 'cc.case_id')
              ->where('cc.category_id', $search['category_id']);
      }
      if ($search['price_min']!=0) {
        $query->whereHas('menus', function ($subquery) use ($search) {
          $subquery->where('price', '>=', $search['price_min']);
        });
      }
      if ($search['price_max']!=0) {
          $query->whereHas('menus', function ($subquery) use ($search) {

               $subquery->where('price', '<=', $search['price_max']);
          });
      }
      if(isset($search['filter'])&&$search['filter']==0)
      {
          //     //$query->selectRaw("menus.*, IF(ISNULL(`diary_menu`.`id`), 0, COUNT(`menus`.`id`)) as diarycount")->leftJoin('diary_menu', 'menus.id', '=', 'diary_menu.menu_id')->groupBy('menus.id');
          // $result=$query->get();
          // return array_slice($result->sortByDesc('likes_count')->values()->all(),($search['page']-1)*$search['per_page'],$search['per_page']);
          $query->orderby('likers_count', 'DESC');
      }
      else if(isset($search['filter'])&&$search['filter']==1){
          $query->orderby('updated_at', 'DESC');
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
