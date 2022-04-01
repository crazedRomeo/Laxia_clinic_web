<?php

namespace App\Observers;

use App\Enums\Common\PointType;
use App\Models\User;
use App\Models\Clinic;
use App\Models\Doctor;
use App\Models\Patient;
use App\Models\Admin;
use App\Models\PointHistory;

class UserObserver
{
    /**
     * Handle the user "created" event.
     *
     * @param  \App\Models\User  $user
     * @return void
     */
    public function created(User $user)
    {
        if ($user->role == 'clinic') {
            Clinic::create([
                'name' => $user->name,
                'user_id' => $user->id
            ]);
        } else if ($user->role == 'doctor') {
            Doctor::create([
                'doctor_id' => $user->id
            ]);
        } else if ($user->role == 'patient') {
            $patient = Patient::create([
                'user_id' => $user->id,
                'point' => config('constants.user_register_add_point'),
            ]);
            PointHistory::create([
                'patient_id' => $patient->id,
                'type' => PointType::USER_NEW_REGISTERED,
                'use_point' => config('constants.user_register_add_point')
            ]);
        }
    }

    /**
     * Handle the user "updated" event.
     *
     * @param  \App\Models\User  $user
     * @return void
     */
    public function updated(User $user)
    {
        //
    }

    /**
     * Handle the user "deleted" event.
     *
     * @param  \App\Models\User  $user
     * @return void
     */
    public function deleted(User $user)
    {
        //
    }

    /**
     * Handle the user "restored" event.
     *
     * @param  \App\Models\User  $user
     * @return void
     */
    public function restored(User $user)
    {
        //
    }

    /**
     * Handle the user "force deleted" event.
     *
     * @param  \App\Models\User  $user
     * @return void
     */
    public function forceDeleted(User $user)
    {
        //
    }
}
