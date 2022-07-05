<?php

namespace App\Observers;

use App\Enums\Common\PointType;
use App\Models\Payment;
use App\Models\Withdraw;
use App\Models\PointHistory;
use Carbon\Carbon;

class PaymentObserver
{
    /**
     * Handle the payment "created" event.
     *
     * @param  \App\Models\Payment  $payment
     * @return void
     */
    public function created(Payment $payment)
    {
        $currentUser = auth()->guard('clinic')->user()->clinic;
        if (!isset($currentUser)) return;

        $ym = Carbon::parse($payment->created_at)->format('Y-m');
        $withdraw = Withdraw::firstOrNew([
            'clinic_id' => $currentUser->id,
            'month' => $ym
        ]);
        $withdraw->price += $payment->total_price;
        $withdraw->save();

        // ユーザーにポイント付与
        $addPoint = floor(config('constants.reservation_success_point_rate') * $payment->treat_price);

        $patient = $payment->reservation->patient;
        PointHistory::create([
            'patient_id' => $patient->id,
            'type' => PointType::RESERVATION_FINISHED,
            'type_id' => $payment->reservation->id,
            'use_point' => $addPoint
        ]);

        $patient->point = $patient->point + $addPoint;
        $patient->save();
    }

    /**
     * Handle the payment "updated" event.
     *
     * @param  \App\Models\Payment  $payment
     * @return void
     */
    public function updated(Payment $payment)
    {
        //
    }

    /**
     * Handle the payment "deleted" event.
     *
     * @param  \App\Models\Payment  $payment
     * @return void
     */
    public function deleted(Payment $payment)
    {
        //
    }

    /**
     * Handle the payment "restored" event.
     *
     * @param  \App\Models\Payment  $payment
     * @return void
     */
    public function restored(Payment $payment)
    {
        //
    }

    /**
     * Handle the payment "force deleted" event.
     *
     * @param  \App\Models\Payment  $payment
     * @return void
     */
    public function forceDeleted(Payment $payment)
    {
        //
    }
}
