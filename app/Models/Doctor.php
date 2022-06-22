<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Master\Pref;
use App\Models\Master\Job;
use App\Models\Master\Speciality;
use App\Models\Diary;

class Doctor extends Model
{
  /**
   * The table associated with the model.
   *
   * @var string
   */
  protected $table = 'doctors';

  /**
   * The attributes that are mass assignable.
   *
   * @var array
   */
  protected $fillable = [
    'clinic_id',
    'user_id',
    'kata_name',
    'hira_name',
    'gender',
    'phone_number',
    'birthday',
    'area_id',
    'job_id',
    'experience_year',
    'spec0',
    'spec1',
    'spec2',
    'profile',
    'career',
    'photo',
  ];

  protected $appends = [

  ];

  protected $hidden = [
    'created_at',
    'updated_at',
  ];

  public function clinic() {
    return $this->belongsTo(Clinic::class);
  }

  public function counselings() {
    return $this->hasMany(CounselingReport::class);
  }

  public function cases() {
    return $this->hasMany(TreatCase::class);
  }
}
