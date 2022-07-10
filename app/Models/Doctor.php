<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Master\Pref;
use App\Models\Master\Job;
use App\Models\Master\Speciality;
use App\Models\Diary;
use App\Models\Master\Category;
use App\Models\DoctorImages;

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
    'diaries_count',
    'avg_rate',
    'categories',
    'job_name',
  ];

  protected $hidden = [
    'created_at',
    'updated_at'
  ];
  public function getFirebaseKeyAttribute()
  {
    if ($this->user()->count()) {
      return $this->user()->first()->firebase_key;
    }
    return null;
  }

  public function user()
  {
    return $this->belongsTo(User::class);
  }
  public function getNameAttribute()
  {
    return $this->user()->first()->name;
  }
  public function getClinicAttribute()
  {
    return $this->clinic()->first();
  }
  public function getEmailAttribute()
  {
    return $this->user()->first()->email;
  }

  public function getRoleAttribute()
  {
    return $this->user()->first()->role;
  }

  public function images()
  {
    return $this->hasMany(DoctorImages::class, 'doctor_id','user_id');
  }
//   public function images()
//   {
//     return $this->morphMany(Attachment::class, 'attachable');
//   }

  public function job()
  {
    return $this->belongsTo(Job::class, 'job_id');
  }

  public function getJobNameAttribute()
  {
    $job = $this->job()->where('id', $this->job_id)->first();
    return $job ? $job->name : null;
  }


  public function speciality0()
  {
    return $this->belongsTo(Speciality::class, 'spec0');
  }

  public function getSpec0NameAttribute()
  {
    $speciality = $this->speciality0()->where('id', $this->spec0)->first();

    if(empty($speciality)) return null;

    $parent = Speciality::where('id', $speciality->parent_id)->first();
    $parent_name = empty($parent) ? '' : $parent->name . ' / ';

    return $speciality ? $parent_name . $speciality->name : null;
  }


  public function speciality1()
  {
    return $this->belongsTo(Speciality::class, 'spec1');
  }

  public function getSpec1NameAttribute()
  {
    $speciality = $this->speciality1()->where('id', $this->spec1)->first();

    if(empty($speciality)) return null;

    $parent = Speciality::where('id', $speciality->parent_id)->first();
    $parent_name = empty($parent) ? '' : $parent->name . ' / ';

    return $speciality ? $parent_name . $speciality->name : null;
  }


  public function speciality2()
  {
    return $this->belongsTo(Speciality::class, 'spec2');
  }

  public function getSpec2NameAttribute()
  {
    $speciality = $this->speciality2()->where('id', $this->spec2)->first();

    if(empty($speciality)) return null;

    $parent = Speciality::where('id', $speciality->parent_id)->first();
    $parent_name = empty($parent) ? '' : $parent->name . ' / ';

    return $speciality ? $parent_name . $speciality->name : null;
  }
  public function getAvgRateAttribute()
  {
     $avg_rate=0;
     $diaries=$this->diaries()->get();
     $count=count($diaries);
     for($i=0;$i< $count;$i++){
        $avg_rate+=$diaries[$i]['ave_rate'];
     }
     if($count){
        return $avg_rate/$count;
     }
     return 0;
  }
  public function getDiariesCountAttribute()
  {
    return $this->diaries()->count();
  }
  public function diaries() {
    return $this->hasMany(Diary::class);
  }

  public function viewers()
  {
    return $this->morphToMany(Patient::class, 'viewable', 'viewables','viewable_id', 'patient_id');
  }

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

  public function getViewsCountAttribute()
  {
    return $this->viewers()->count();
  }
  public function questions()
  {
    return $this->belongsToMany(Question::class, 'answers', 'doctor_id', 'question_id');
  }
  public function clinic() {
    return $this->belongsTo(Clinic::class);
  }

  public function counselings() {
    return $this->hasMany(CounselingReport::class);
  }

  public function cases() {
    return $this->hasMany(TreatCase::class);
  }
  public function getCategoriesAttribute()
  {
    return $this->categories()->get();
  }
  public function categories()
  {
    return $this->belongsToMany(Category::class, 'doctor_categories', 'doctor_id', 'category_id');
  }
}
