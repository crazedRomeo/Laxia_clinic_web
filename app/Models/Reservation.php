<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Reservation extends Model
{
  /**
   * The table associated with the model.
   *
   * @var string
   */
  protected $table = 'reservations';

  /**
   * The attributes that are mass assignable.
   *
   * @var array
   */
  protected $fillable = [
    'visit_date',
    'start_time',
    'end_time',
    'clinic_id',
    'patient_id',
    'doctor_id',
    'status',
    'hope_treat',
    'note',
    'use_point'
  ];

  protected $appends = [
    'last_chat_time',
    'start_time_without_sec',
  ];

  public function getLastChatTimeAttribute()
  {
    return $this->hasOne(Mailbox::class)->first()->hasMany(Message::class)->orderBy('created_at', 'desc')->first();
  }

  public function getStartTimeWithoutSecAttribute() {
    return empty($this->start_time) ? '': substr($this->start_time, 0, 5);
  }

  public function clinic()
  {
    return $this->belongsTo(Clinic::class);
  }

  public function patient()
  {
    return $this->belongsTo(Patient::class);
  }

  public function doctor()
  {
    return $this->belongsTo(Doctor::class);
  }

  public function hopeTimes()
  {
    return $this->hasMany(RsvHopeTime::class);
  }

  public function payments()
  {
    return $this->hasOne(Payment::class);
  }

  public function mailbox()
  {
    return $this->hasOne(Mailbox::class);
  }

  // public function hopeCategories()
  // {
  //   return $this->belongsToMany(TreatCategory::class, 'reservation_categories', 'reservation_id', 'category_id');
  // }
}
