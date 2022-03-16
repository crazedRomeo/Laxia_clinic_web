<?php
namespace App\Services;

use Illuminate\Support\Arr;
use App\Models\Doctor;
use App\Models\Attachment;
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

    $query = Doctor::query();
    if (isset($search['q'])) {
      $query->where('name', 'LIKE', "%{$search['q']}%");
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

    if (isset($search['pref_id'])) {
      $query->where('pref_id', $search['pref_id']);
    }

    if (isset($search['city'])) {
      $query->where('addr01', 'LIKE', "%{$search['city']}%");
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
    }

    return $query->paginate($per_page);
  }

  public function get($id)
  {
    return Doctor::with([
        'images',
      ])
      ->where('doctor_id', $id)
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
}
