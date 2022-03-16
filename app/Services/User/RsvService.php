<?php
namespace App\Services\User;

use Illuminate\Support\Arr;
use App\Models\Reservation;
use App\Models\Payment;
use App\Models\Patient;
use App\Models\RsvHopeTime;
use DB;
use Auth;
use Throwable;

/**
 * Class RsvService
 * @package App\Services
 */
class RsvService
{
  public function paginate($search)
  {
    $per_page = isset($search['per_page']) ? $search['per_page'] : 20;
    $query = Reservation::query()
      ->with(['patient', 'doctor', 'clinic']);
    
    if (isset($search['clinic_id'])) {
      $query->where('clinic_id', $search['clinic_id']);
    }
    
    if (isset($search['status'])) {
      $status = $search['status'];
      if ($status == 1) {
        $query->whereIn('status', [5, 10]);
      } else if ($status == 2) {
        $query->where('status', '20');
      } else if ($status == 3) {
        $query->where('status', '25');
      } else if ($status == 4) {
        $query->where('status', '30');
      }
    }

    if (isset($search['patient_id'])) {
      $query->where('patien_id', $search['patient_id']);
    }

    // 決済一覧
    if (isset($search['confirmed'])) {
      $query->whereNotNull('visit_date')
        ->whereDoesntHave('payment')
        ->orderBy('visit_date', 'asc');
    }

    $query->orderby('updated_at', 'desc');
    
    return $query->paginate($per_page);
  }

  public function getCountInfo($where)
  {
    $totalCount = Reservation::where($where)
      ->get()
      ->count();
    $notSupportedCount = Reservation::where($where)
      ->where('status', '5')
      ->get()
      ->count();
    $missedCallCount = Reservation::where($where)
      ->where('status', '10')
      ->get()
      ->count();
    $inProgressCount = Reservation::where($where)
      ->where('status', '15')
      ->get()
      ->count();
    $approvedCount = Reservation::where($where)
      ->where('status', '20')
      ->get()
      ->count();
    
    return [
      'all' => $totalCount,
      'not_supported' => $notSupportedCount,
      'missed_call' => $missedCallCount,
      'in_progress' => $inProgressCount,
      'approved' => $approvedCount,
    ];
  } 

  public function get($id)
  {
    return Reservation::with(['patient', 'doctor', 'clinic'])
      ->findOrFail($id);
  }

  public function store($attributes, $addtional = [])
  {
    $rsvAttrs = Arr::get($attributes, 'rsv');
    
    $addtional['status'] = 5;
    $data = array_merge($rsvAttrs, $addtional);
    $rsv = Reservation::create($data);

    $categoryAttrs = Arr::get($attributes, 'categories');
    $rsv->hopeCategories()->sync($categoryAttrs);

    $timeAttrs = Arr::get($attributes, 'time');
    foreach ($timeAttrs as $item)
    {
      if (isset($item['date']) && isset($item['start_time']) && isset($item['end_time'])) {
        $time = RsvHopeTime::create($item);
        $rsv->hopeTimes()->save($time);
      }
    }

    return $rsv;
  }

  public function update($attributes, $where)
  {
    $rsvAttrs = Arr::get($attributes, 'reservations');
    $rsv = Reservation::where($where)
      ->firstOrFail();
    $rsv->fill($rsvAttrs);
    $rsv->save();

    // $patientInfoAttrs = Arr::get($attributes, 'patient_infos');
    // if (isset($patientInfoAttrs)) {
    //   $rsv->patient_info()->update($patientInfoAttrs);
    // }

    return $rsv->load(['patient', 'doctor', 'clinic']);
  }

  public function updateStatus($id, $status)
  {
    $rsv = Reservation::findOrFail($id);
    $rsv->status = $status;
    $rsv->save();

    return $rsv->load(['patient', 'doctor', 'clinic']);
  }

  public function updatePayment($attrs, $where)
  {
    $payAttrs = Arr::get($attrs, 'payments');
    $rsv = Reservation::where($where)->firstOrFail();
    $payment = Payment::updateOrCreate(
      [ 'reservation_id' => $rsv->id ],
      $payAttrs
    );

    return $rsv->load(['patient', 'doctor', 'clinic']);
  }

  public function getPatientInfo($patient_id)
  {
    $patient = Patient::find($patient_id);
    if (!$patient) return null;
    return $patient;
  }
}
