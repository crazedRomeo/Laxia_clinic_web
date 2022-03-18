<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Master\Speciality;
use App\Models\Master\Job;

class Stuff extends Model
{
  /**
   * The table associated with the model.
   *
   * @var string
   */
  protected $table = 'stuffs';

  /**
   * The attributes that are mass assignable.
   *
   * @var array
   */
  protected $fillable = [
    'clinic_id',
    'name',
    'kana',
    'duty',
    'job_id',
    'experience_year',
    'career',
    'profile',
    'photo',
    'ave_diaries_rate'
  ];

  protected $appends = [
    'clinic_name',
    'job_name',
    'diaries_count',
    'counseling_count',
    // 'cases_count',
    'likes_count',
    'is_like',
    // 'favoriters_count',
    'is_favorite',
    'views_count',
  ];

  public function clinic()
  {
    return $this->belongsTo(Clinic::class);
  }

  public function job()
  {
    return $this->belongsTo(Job::class);
  }

  public function specialities()
  {
    return $this->belongsToMany(Speciality::class, 'stuff_specialities', 'stuff_id', 'speciality_id');
  }

  // public function cases()
  // {
  //   return $this->hasMany(TreatCase::class);
  // }

  // public function getCasesCountAttribute()
  // {
  //   return $this->cases()->count();
  // }

  public function diaries()
  {
    return $this->hasMany(Diary::class, 'doctor_id');
  }

  public function getDiariesCountAttribute()
  {
    return $this->diaries()->count();
  }

  public function counseling()
  {
    return $this->hasMany(CounselingReport::class);
  }

  public function getCounselingCountAttribute()
  {
    return $this->counseling()->count();
  }

  // いいめ
  public function likers()
  {
      return $this->morphToMany(Patient::class, 'likeable');
  }

  public function getLikesCountAttribute()
  {
      return $this->likers()->count();
  }

  public function getIsLikeAttribute()
  {
      $currentUser = auth()->guard('patient')->user();
      if (!$currentUser || !isset($currentUser->patient)) return false;
      $likerIds = $this->likers()
        ->get()
        ->pluck('id')
        ->toArray();
      return in_array($currentUser->patient->id, $likerIds);
  }

  public function getClinicNameAttribute()
  {
    if ($this->clinic()->count()) {
      return $this->clinic()->first()->name;
    }
    return null;
  }

  public function getJobNameAttribute()
  {
    if ($this->job()->count()) {
      return $this->job()->first()->name;
    }
    return null;
  }

  public function favoriters()
  {
    return $this->morphToMany(Patient::class, 'favoriable', 'favorites');
  }

  public function getFavoritersCountAttribute()
  {
    return $this->favoriters()->count();
  }

  public function getIsFavoriteAttribute()
  {
    $currentUser = auth()->guard('patient')->user();
    if (!$currentUser || !($currentUser->patient)) return false;
    $favoriterIds = $this->favoriters()
      ->get()
      ->pluck('id')
      ->toArray();
    return in_array($currentUser->patient->id, $favoriterIds);
  }

  public function viewers()
  {
    return $this->morphToMany(Patient::class, 'viewable', 'viewables','viewable_id', 'patient_id');
  }

  public function getViewsCountAttribute()
  {
    return $this->viewers()->count();
  }
}
