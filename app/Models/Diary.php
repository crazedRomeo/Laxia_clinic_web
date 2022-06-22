<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Master\DiaryRateQuestion;
use App\Models\Master\DiaryTextQuestion;
use App\Models\Master\Category;

class Diary extends Model
{
  /**
   * The table associated with the model.
   *
   * @var string
   */
  protected $table = 'diaries';

  /**
   * The attributes that are mass assignable.
   *
   * @var array
   */
  protected $fillable = [
    'patient_id',
    'clinic_id',
    'doctor_id',
    'treat_date',
    'price',
    'rate_01',
    'rate_02',
    'rate_03',
    'rate_04',
    'rate_05',
    'rate_06',
    'rate_07',
    'rate_08',
    'rate_09',
    'ave_rate',
    'cost_anesthetic',
    'cost_drug',
    'cost_other',
  ];

  protected $appends = [
    'views_count',
    'comments_count',
    'likes_count',
    'is_like',
    'before_image',
    'after_image',
    'patient_nickname',
    'patient_gender',
    'patient_photo',
    'patient_age',
    'clinic_name',
    'doctor_name',
    // 'ave_rate',
    'last_content',
    'is_favorite',
  ];

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

  public function getPatientAgeAttribute()
  {
    if ($this->owner()->count()) {
      return $this->owner()->first()->age;
    }
    return null;
  }

  public function getPatientGenderAttribute()
  {
    if ($this->owner()->count()) {
      return $this->owner()->first()->gender;
    }
    return null;
  }

  public function getClinicNameAttribute()
  {
    if ($this->clinic()->count()) {
      return $this->clinic()->first()->name;
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

  public function getCommentsCountAttribute()
  {
    $count = 0;
    foreach ($this->progresses()->get() as $progress) {
      $count += $progress->comments()->count();
    }
    return $count;
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

  //
  public function owner()
  {
    return $this->belongsTo(Patient::class, 'patient_id');
  }

  public function clinic()
  {
    return $this->belongsTo(Clinic::class);
  }

  public function doctor()
  {
    return $this->belongsTo(Doctor::class);
  }

  public function categories()
  {
    return $this->belongsToMany(Category::class, 'diary_categories', 'diary_id', 'category_id');
  }

  // public function rate_questions()
  // {
  //   return $this->belongsToMany(DiaryRateQuestion::class, 'diary_rate_questions', 'diary_id', 'question_id')
  //     ->withPivot('rate');
  // }

  // public function getAveRateAttribute()
  // {
  //   $i = 0; $sum = 0;
  //   foreach ($this->rate_questions()->get() as $rq)
  //   {
  //     if ($rq->pivot->rate != 0) {
  //       $sum += $rq->pivot->rate;
  //       $i++;
  //     }
  //   }
  //   if ($i == 0) return null;
  //   return round($sum/$i, 1);
  // }

  public function text_questions()
  {
    return $this->belongsToMany(DiaryTextQuestion::class, 'diary_text_questions', 'diary_id', 'question_id')
      ->withPivot('answer');
  }

  public function progresses()
  {
    return $this->hasMany(TreatProgress::class);
  }

  public function last_progress()
  {
    return $this->hasMany(TreatProgress::class)
      ->orderby('updated_at', 'desc')
      ->take(1);
  }

  public function medias()
  {
    return $this->morphMany(Media::class, 'mediable');
  }

  public function menus()
  {
    return $this->belongsToMany(Menu::class)
      ->withPivot('cost');
  }

  // Attribute Functions
  public function getBeforeImageAttribute()
  {
    if ($this->medias()->count() == 0) {
      return null;
    }
    $first_media = $this->medias()->first();
    return $first_media->thumb_path;
  }

  public function getAfterImageAttribute()
  {
    if ($this->progresses()->count() == 0) {
      return null;
    }
    $last_progress = $this->progresses()
      ->orderBy('updated_at', 'DESC')
      ->first();
    if ($last_progress->medias()->count() == 0) {
      return null;
    }
    $media = $last_progress->medias()->first();
    return $media->thumb_path;
  }

  public function getLastContentAttribute()
  {
    if ($this->progresses()->count() == 0) {
      $question = $this->text_questions()->where('question_id', 1)->first();
      if (isset($question)) {
        return $question->pivot->answer;
      }
      return null;
    } else {
      $last_progress = $this->progresses()
        ->orderBy('updated_at', 'DESC')
        ->first();
      return $last_progress->content;
    }
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

  public function comments()
  {
      return $this->hasManyThrough(Comment::class, TreatProgress::class, 'diary_id', 'commentable_id')
        ->where('commentable_type', 'App\Models\TreatProgress');
  }
}
