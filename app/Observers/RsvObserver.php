<?php

namespace App\Observers;

use App\Models\User;
use App\Models\Clinic;
use App\Models\Admin;
use App\Models\Reservation;
use App\Models\Mailbox;
use App\Models\PointHistory;

class RsvObserver
{
    /**
     * Handle the user "created" event.
     *
     * @param  \App\Models\Reservation  $rsv
     * @return void
     */
    public function created(Reservation  $rsv)
    {
        $mailbox = Mailbox::create([
            'reservation_id' => $rsv->id
        ]);
        $patient = $rsv->patient;
        $mailbox->users()->attach([
            $rsv->clinic->user->id,
            $patient->user->id
        ]);

        // ポイント削減
        PointHistory::create([
            'patient_id' => $patient->id,
            'type' => 'reservation_requested',
            'type_id' => $rsv->id,
            'use_point' => $rsv->use_point * (-1),
        ]);
        $patient->point = $patient->point - $rsv->use_point;
        $patient->save();
    }

    /**
     * Handle the user "updated" event.
     *
     * @param  \App\Models\Reservation  $rsv
     * @return void
     */
    public function updated(Reservation  $rsv)
    {
        //
    }

    /**
     * Handle the user "deleted" event.
     *
     * @param  \App\Models\Reservation  $rsv
     * @return void
     */
    public function deleted(Reservation  $rsv)
    {
        //
    }

    /**
     * Handle the user "restored" event.
     *
     * @param  \App\Models\Reservation  $rsv
     * @return void
     */
    public function restored(Reservation  $rsv)
    {
        //
    }

    /**
     * Handle the user "force deleted" event.
     *
     * @param  \App\Models\Reservation  $rsv
     * @return void
     */
    public function forceDeleted(Reservation  $rsv)
    {
        //
    }
}
