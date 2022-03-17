<?php
namespace App\Services;

use Illuminate\Support\Arr;
use App\Models\Withdraw;
use DB;
use Auth;
use Throwable;

/**
 * Class WithdrawService
 * @package App\Services
 */
class WithdrawService
{
  public function paginate($search)
  {
    $per_page = isset($search['per_page']) ? $search['per_page'] : 20;

    $query = Withdraw::query();
    
    if (isset($search['clinic_id'])) {
      $clinicId = $search['clinic_id'];
      $query->where('clinic_id', $clinicId);
    }

    if (isset($search['is_paid']) && $search['is_paid']) {
      $query->whereNotNull('paid_at');
    }

    // $query->orderby('created_at', 'desc');
    $query->orderby('month', 'desc');

    return $query->paginate($per_page);
  }

  public function getWhere($where)
  {
    return Withdraw::where($where)
      ->first();
  }
}
