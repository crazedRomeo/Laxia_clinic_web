<?php
namespace App\Services;

use Illuminate\Support\Arr;
use App\Models\Doctor;
use App\Models\Attachment;
use App\Models\Master\Category;

use DB;
use Auth;
use Throwable;

/**
 * Class DoctorService
 * @package App\Services
 */
class DoctorService
{
  public function paginate($search) {
    $per_page = isset($search['per_page']) ? $search['per_page'] : 20;
    $diary_acount = \DB::table('diaries')
    ->select('doctor_id', DB::raw('avg(ave_rate) as ave_rate, count(id) as diaries_count'))
    ->groupBy('doctor_id');
    $query = Doctor::query()->leftJoinSub($diary_acount, 'diary_avg', function ($join) {
        $join->on('doctors.id', '=', 'diary_avg.doctor_id');
      });
    if (isset($search['category_id']))
    {
    //   $ids = Category::whereIn('id',explode(',',$search['category_id']))->select('id')->get();
    // //   $ids = $category->descendantsAndSelf()->pluck('id');
    //   $query->whereHas('categories', function($subquery) use ($ids) {
    //     $subquery->whereIn('doctor_categories.category_id', $ids);
    //   });
        $query->whereHas('categories',function($suvquery) use ($search) {
        $suvquery->whereIn('doctor_categories.id',explode(',',$search['category_id']));
    });
    }
    if(isset($search['q']) && $search['q'] != '') {
      $query->where(function($query) use ($search) {
              $query->where('kata_name', 'like', "%{$search['q']}%")
              ->orWhere('hira_name', 'like', "%{$search['q']}%");
      });
    }

    if (isset($search['favorite']) && $search['favorite'] == 1)
    {
      $currentUser = auth()->guard('doctor')->user();
      if (isset($currentUser) && isset($currentUser->doctor)) {
        $doctor_id = $currentUser->doctor->id;
        $query->whereIn('id', function($subquery) use ($doctor_id) {
          $subquery->select('favoriable_id')
            ->from('favorites')
            ->where('favoriable_type', 'App\Models\Doctor')
            ->where('doctor_id', $doctor_id);
        });
      }
    }

    if (isset($search['clinic_id'])) {
      $query->where('clinic_id', $search['clinic_id']);
    }
    if(isset($search['filter'])&&$search['filter']==0)
    {
        //$query->selectRaw("menus.*, IF(ISNULL(`diary_menu`.`id`), 0, COUNT(`menus`.`id`)) as diarycount")->leftJoin('diary_menu', 'menus.id', '=', 'diary_menu.menu_id')->groupBy('menus.id');
        // $result=$query->get();
        // return array_slice($result->sortByDesc('avg_rate')->values()->all(),($search['page']-1)*$search['per_page'],$search['per_page']);
        $query->orderby('ave_rate', 'DESC');
    }else if(isset($search['filter'])&&$search['filter']==1){
        // $result=$query->get();
        // return array_slice($result->sortByDesc('diaries_count')->values()->all(),($search['page']-1)*$search['per_page'],$search['per_page']);
        $query->orderby('diaries_count', 'DESC');
    }
    // if (isset($search['pref_id'])) {
    //   $query->where('pref_id', $search['pref_id']);
    // }

    // if (isset($search['city'])) {
    //   $query->where('addr01', 'LIKE', "%{$search['city']}%");
    // }

    // if (isset($search['orderby'])) {
    //   $orderby = $search['orderby'];
    //   if ($orderby == 'diaries_count') {
    //     $query->withCount('diaries')
    //       ->orderBy('diaries_count', 'DESC');
    //   }
    //   if ($orderby == 'rate') {
    //     $query->orderBy('ave_diaries_rate', 'DESC');
    //   }
    // }
    // if(isset($search['filter'])&&$search['filter']==0)
    // {
    //     //$query->selectRaw("menus.*, IF(ISNULL(`diary_menu`.`id`), 0, COUNT(`menus`.`id`)) as diarycount")->leftJoin('diary_menu', 'menus.id', '=', 'diary_menu.menu_id')->groupBy('menus.id');
    //     $result=$query->get();
    //     return array_slice($result->sortByDesc('diaries_count')->values()->all(),($search['page']-1)*$search['per_page'],$search['per_page']);
    // }else if(isset($search['filter'])&&$search['filter']==1){
    //     $result=$query->get();
    //     return array_slice($result->sortBy('diaries_count')->values()->all(),($search['page']-1)*$search['per_page'],$search['per_page']);
    // }
    return $query->paginate($per_page);
  }

  public function get($id)
  {
    return Doctor::with([
        'images',
        'diaries',
        'cases',
        'counselings',
        'questions',
        'clinic'
      ])
      ->where('id', $id)
      ->firstOrFail();
  }

  public function update($attributes, $where)
  {
    $doctor = Doctor::where($where)->firstOrFail();
    $doctor->fill($attributes);
    $doctor->save();
    return $doctor;
  }

  public function getDoctorsByClinic($clinic_id) {
    return Doctor::where('clinic_id', $clinic_id)->get();
  }

  public function getDoctorsCountByClinic($clinic_id, $request = array()) {
    $query = Doctor::where('clinic_id', $clinic_id);

    if(isset($request['q'])) {
      $query->where(function($query) use ($request) {
        $query->where('kata_name', 'LIKE', "%{$request['q']}%")
              ->orWhere('hira_name', 'LIKE', "%{$request['q']}%");
      });
    }

    return $query->count();
  }

  public function setClinic($doctor_id, $clinic_id) {
    $doctor = Doctor::find($doctor_id);

    $doctor->clinic_id = $clinic_id;
    $doctor->save();

    return $doctor;
  }

  public function deleteClinic($doctor_id) {
    $doctor = Doctor::find($doctor_id);

    $doctor->clinic_id = null;
    $doctor->save();

    return $doctor;
  }

  public function search($request) {
    $doctors = Doctor::where('kata_name', 'LIKE', "%{$request['q']}%")
                  ->orWhere('hira_name', 'LIKE', "%{$request['q']}%")
                  ->get();

    return $doctors;
  }
}
