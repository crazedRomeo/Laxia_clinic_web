<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Master\Category;

class Menu extends Model
{
  /**
   * The table associated with the model.
   *
   * @var string
   */
  protected $table = 'menus';

  /**
   * The attributes that are mass assignable.
   *
   * @var array
   */
  protected $fillable = [
    'clinic_id',
    'name',
    'price',
    'description',
    'risk',
    'guarantee',
    'treat_time',
    'required_time',
    'masui',
    'hospital_visit',
    'hare',
    'pain',
    'bleeding',
    'hospital_need',
    'basshi',
    'makeup',
    'shower',
    'massage',
    'sport_impossible',
    'photo',
    'status'
  ];

  protected $appends = [
    'is_favorite',
    'diarycount'
  ];

  public function clinic()
  {
    return $this->belongsTo(Clinic::class);
  }

  public function cases()
  {
    return $this->hasMany(TreatCase::class);
  }

  public function categories()
  {
      return $this->belongsToMany(Category::class, 'menu_categories', 'menu_id', 'category_id');
  }

  public function images()
  {
      // return $this->belongsToMany(Menu::class, 'menu_photos', 'menu_id');
      return $this->morphMany(Attachment::class, 'attachable');
  }

  public function scopePublic($query)
  {
    return $query->where('status', 1);
  }
  public function getDiarycountAttribute(){
    return  $this->diaries()->count();
  }
  public function diaries()
  {
    return $this->belongsToMany(Diary::class,'diary_menu','menu_id','diary_id');
  }

  public function favoriters()
  {
    return $this->morphToMany(Patient::class, 'favoriable', 'favorites');
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
