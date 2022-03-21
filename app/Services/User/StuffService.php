<?php
namespace App\Services\User;

use Illuminate\Support\Arr;
use App\Models\Stuff;
use DB;
use Auth;
use Throwable;

/**
 * Class StuffService
 * @package App\Services
 */
class StuffService
{
  public function paginate($search)
  {
    $per_page = isset($search['per_page']) ? $search['per_page'] : 20;
    $query = Stuff::query()
      ->with(['specialities']);
    if (isset($search['clinic_id'])) {
      $query->where('clinic_id', $search['clinic_id']);
    }

    if (isset($search['favorite']) && $search['favorite'] == 1)
    {
      $currentUser = auth()->guard('patient')->user();
      if (isset($currentUser) && isset($currentUser->patient)) {
        $patient_id = $currentUser->patient->id;
        $query->whereIn('id', function($subquery) use ($patient_id) {
          $subquery->select('favoriable_id')
            ->from('favorites')
            ->where('favoriable_type', 'App\Models\Stuff')
            ->where('patient_id', $patient_id);
        });
      }
    }

    if (isset($search['pref_id'])) {
      $pref_id = $search['pref_id'];
      $query->whereHas('clinic', function($subquery) use ($pref_id) {
        $subquery->where('pref_id', $pref_id);
      });
    }
    
    // if (isset($search['city'])) {
    //   $city = $search['city'];
    //   $query->whereHas('clinic', function($subquery) use ($city) {
    //     $subquery->where('addr01', "LIKE", "%{$city}%");
    //   });
    // }

    if (isset($search['q'])) {
      $q = $search['q'];
      $query->where('name', 'LIKE', "%{$q}%");
    }

    if (isset($search['orderby'])) {
      $orderby = $search['orderby'];
      if ($orderby == 'diaries_count') {
        $query->withCount('diaries')
          ->orderBy('diaries_count', 'DESC');
      }
      if ($orderby == 'rate') {
        $query->orderBy('ave_diaries_rate', 'DESC');
      }
    } else {
      $query->orderby('created_at', 'desc');
    }

    return $query->paginate($per_page);
  }

  public function toArray($params)
  {
    $query = Stuff::query();
    if (isset($params['clinic_id'])) {
      $query->where('clinic_id', $params['clinic_id']);
    }
    $query->orderby('created_at', 'desc');
    return $query->get()
      ->pluck('name', 'id')
      ->toArray();
  }

  public function get($id)
  {
    return Stuff::findOrFail($id);
  }

  public function store($attributes, $addtional = [])
  {
    $stuffAttrs = Arr::get($attributes, 'stuffs');
    $specialitiesAttrs = Arr::get($attributes, 'specialities');
    
    $data = array_merge($stuffAttrs, $addtional);
    $stuff = Stuff::create($data);
    if ($specialitiesAttrs) {
      $stuff->specialities()->sync(array_filter($specialitiesAttrs));
    }

    return $stuff;
  }

  public function update($attributes, $where)
  {
    $stuffAttrs = Arr::get($attributes, 'stuffs');
    $stuff = Stuff::where($where)->firstOrFail();
    $stuff->fill($stuffAttrs);
    $stuff->save();

    $specialitiesAttrs = Arr::get($attributes, 'specialities');
    $stuff->specialities()->sync(array_filter($specialitiesAttrs));

    return $stuff;
  }
}
