<?php
namespace App\Services;

use Illuminate\Support\Arr;
use App\Models\User;
use App\Models\Doctor;
use App\Models\Attachment;
use App\Enums\User\Type as UserType;
use DB;
use Auth;
use Throwable;

/**
 * Class SearchDoctorService
 * @package App\Services
 */
class SearchDoctorService
{
  public function search($search) {
    /*
    $per_page = isset($search['per_page']) ? $search['per_page'] : 20;

    $query = User::query();
    if (isset($search['q'])) {
      $query->where('name', 'LIKE', "%{$search['q']}%")
      ->where('role', UserType::DOCTOR)
      ->join('doctors', 'doctors.user_id', '=', 'users.id');
    }

    return $query->paginate($per_page);
    */

    $doctor = User::where(['name' => $search['q'], 'role' => UserType::DOCTOR])
      ->join('doctors', 'doctors.user_id', '=', 'users.id')
      ->first();

    return $doctor;
  }
}
