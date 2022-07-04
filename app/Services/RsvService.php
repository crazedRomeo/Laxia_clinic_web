<?php
namespace App\Services;

use Illuminate\Support\Arr;
use App\Models\Reservation;
use App\Models\Payment;
use App\Models\Patient;
use App\Models\RsvHopeTime;
use App\Enums\Reservation\Status;
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
      ->with(['patient', 'doctor', 'clinic', 'payments', 'mailbox']);

    if (isset($search['clinic_id'])) {
      $query->where('clinic_id', $search['clinic_id']);
    }

    if (isset($search['status']) && $search['status']) {
      $query->where('status', $search['status']);
    }

    if (isset($search['patient_id'])) {
      $query->where('patient_id', $search['patient_id']);
    }

    // 決済一覧
    if (isset($search['confirmed'])) {
      $query->whereNotNull('visit_date')
        // ->whereDoesntHave('payment')
        ->where('status', Status::INPROGRESS)
        ->orderBy('visit_date', 'asc');
    }

    $query->orderby('updated_at', 'desc');

    return $query->paginate($per_page);
  }

  public function getCountInfo($where)
  {
    $totalCount = Reservation::where($where)->count();
    $notSupportedCount = Reservation::where($where)->where('status', Status::NOTSUPPORTED)->count();
    $inProgressCount = Reservation::where($where)->where('status', Status::INPROGRESS)->count();

    return [
      'all' => $totalCount,
      'not_supported' => $notSupportedCount,
      'in_progress' => $inProgressCount,
    ];
  }

  public function get($id)
  {
    return Reservation::with(['patient', 'doctor', 'clinic', 'payments', 'mailbox'])
      ->findOrFail($id);
  }

  public function store($attributes, $addtional = [])
  {
    $rsvAttrs = Arr::get($attributes, 'rsv');

    $addtional['status'] = 5;
    $data = array_merge($rsvAttrs, $addtional);
    $rsv = Reservation::create($data);

    // $categoryAttrs = Arr::get($attributes, 'categories');
    // $rsv->hopeCategories()->sync($categoryAttrs);

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
    unset($rsvAttrs['use_point']);

    $rsv = Reservation::where($where)
      ->firstOrFail();
    $rsv->fill($rsvAttrs);
    $rsv->save();

    return $rsv->load(['patient', 'doctor', 'clinic', 'payments', 'mailbox']);
  }

  public function updateStatus($id, $status)
  {
    $rsv = Reservation::findOrFail($id);
    $rsv->status = $status;
    $rsv->save();

    return $rsv->load(['patient', 'doctor', 'clinic', 'payments', 'mailbox']);
  }

  public function updatePayment($attrs, $where)
  {
    $payAttrs = Arr::get($attrs, 'payments');
    $rsv = Reservation::where($where)->firstOrFail();
    $payment = Payment::updateOrCreate(
      [ 'reservation_id' => $rsv->id ],
      $payAttrs
    );

    return $rsv->load(['patient', 'doctor', 'clinic', 'payments', 'mailbox']);
  }

  public function getPatientInfo($patient_id)
  {
    $patient = Patient::find($patient_id);
    if (!$patient) return null;
    return $patient;
  }

  public function delete($id) {
    Reservation::where('id', $id)->delete();

    return true;
  }
}
