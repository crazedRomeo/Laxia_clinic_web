<?php
namespace App\Services;

use Illuminate\Support\Arr;
use App\Models\Clinic;
use App\Models\Attachment;
use DB;
use Auth;
use Throwable;

/**
 * Class ClinicService
 * @package App\Services
 */
class ClinicService
{
  public function paginate($search) {
    $per_page = isset($search['per_page']) ? $search['per_page'] : 20;

    $query = Clinic::query();
    if (isset($search['q'])) {
      $query->where('name', 'LIKE', "%{$search['q']}%");
    }

    // if (isset($search['favorite']) && $search['favorite'] == 1)
    // {
    //   $currentUser = auth()->guard('patient')->user();
    //   if (isset($currentUser) && isset($currentUser->patient)) {
    //     $patient_id = $currentUser->patient->id;
    //     $query->whereIn('id', function($subquery) use ($patient_id) {
    //       $subquery->select('favoriable_id')
    //         ->from('favorites')
    //         ->where('favoriable_type', 'App\Models\Clinic')
    //         ->where('patient_id', $patient_id);
    //     });
    //   }
    // }

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

    return $query->paginate($per_page);
  }

  public function get($id)
  {
    return Clinic::with([
        'images',
        // 'menus_limit2',
        // 'stuffs_limit4',
        'doctors',
        'menus',
        'counselings',
      ])
      ->where('id', $id)
      ->firstOrFail();
  }

  public function update($attributes, $where)
  {
    $clinicAttrs = Arr::get($attributes, 'clinic');
    $clinic = Clinic::where($where)->firstOrFail();
    $clinic->fill($clinicAttrs);
    $clinic->save();

    $companyPhotos = Arr::get($attributes, 'companyPhotos');
    $clinic->images()->delete();
    foreach ($companyPhotos as $photo) {
      $clinic->images()->create([
        'path' => $photo
      ]);
    }

    return $clinic;
  }

  public function getProfile($id)
  {
    return Clinic::with([
        'images',
        // 'menus_limit2',
        // 'stuffs_limit4',
        'doctors',
        'menus',
        'counselings',
      ])
      ->where('user_id', $id)
      ->firstOrFail();
  }
}
