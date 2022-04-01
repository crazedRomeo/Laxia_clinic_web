<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Master\Category;

class CounselingReport extends Model
{
  /**
   * The table associated with the model.
   *
   * @var string
   */
  protected $table = 'counseling_reports';

  /**
   * The attributes that are mass assignable.
   *
   * @var array
   */
  protected $fillable = [
    'patient_id',
    'clinic_id',
    'doctor_id',
    'counseling_date',
    'content',
    'reason',
    'before_counseling',
    'after_ccounseling',
    'rate',
  ];

  protected $appends = [
    'views_count',
    'comments_count',
    'likes_count',
    'is_like',
    'clinic_name',
    'patient_nickname',
    'patient_photo',
    'doctor_name',
    // 'favoriters_count',
    'is_favorite',
  ];

  public function getClinicNameAttribute()
  {
    if ($this->clinic()->count()) {
      return $this->clinic()->first()->name;
    }
    return null;
  }

  public function getPatientNicknameAttribute()
  {
    if ($this->owner()->count()) {
      return $this->owner()->first()->nickname;
    }
    return null;
  }

  public function getPatientPhotoAttribute()
  {
    if ($this->owner()->count()) {
      return $this->owner()->first()->photo;
    }
    return null;
  }

  public function getDoctorNameAttribute()
  {
    if ($this->doctor()->count()) {
      return $this->doctor()->first()->name;
    }
    return null;
  }

  public function viewers()
  {
    return $this->morphToMany(Patient::class, 'viewable', 'viewables','viewable_id', 'patient_id');
  }

  public function getViewsCountAttribute()
  {
    return $this->viewers()->count();
  }

  public function comments()
  {
    return $this->morphMany(Comment::class, 'commentable');
  }

  public function getCommentsCountAttribute()
  {
    return $this->comments()->count();
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
    if (!$currentUser) return false;
    $likerIds = $this->likers()
      ->get()
      ->pluck('id')
      ->toArray();
    return in_array($currentUser->patient->id, $likerIds);
  }

  public function owner()
  {
    return $this->belongsTo(Patient::class, 'patient_id', 'id');
  }

  public function clinic()
  {
    return $this->belongsTo(Clinic::class);
  }

  public function questions()
  {
    return $this->hasMany(CounselingQuestion::class);
  }

  public function medias()
  {
    return $this->morphMany(Media::class, 'mediable');
  }

  public function mediaSelf()
  {
    return $this->medias()->where('category', 'self');
  }

  public function mediaLike()
  {
    return $this->medias()->where('category', 'like');
  }

  public function mediaDislike()
  {
    return $this->medias()->where('category', 'dislike');
  }

  public function categories()
  {
    return $this->belongsToMany(Category::class, 'counseling_categories', 'counseling_id', 'category_id');
  }

  public function doctor()
  {
    return $this->belongsTo(Doctor::class);
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
}
