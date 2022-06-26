<?php

namespace App\Models;

use App\Models\Master\Category;
use Illuminate\Database\Eloquent\Model;
use App\Models\Master\City;
use App\Models\Master\DayInfo;
use App\Models\Master\Pref;
use App\Models\Master\Town;

class Clinic extends Model
{
  /**
   * The table associated with the model.
   *
   * @var string
   */
  protected $table = 'clinics';

  /**
   * The attributes that are mass assignable.
   *
   * @var array
   */
  protected $fillable = [
    'user_id',
    'name',
    'pref_id',
    'city_id',
    'town_id',
    'addr02',
    'nearest_station',
    'site',
    'access',
    'phone_number',
    'credit_card',
    'parking',
    'photo',
  ];

  protected $appends = [
    'firebase_key',
    'diaries_count',
    'counselings_count',
    'menus_count',
    'stuffs_count',
    'favoriters_count',
    'is_favorite',
    'address',
    'addr01',
    'user_name',
    'email',
    'role',
    'work_times',
  ];

  public function getFirebaseKeyAttribute()
  {
    if ($this->user()->count()) {
      return $this->user()->first()->firebase_key;
    }
    return null;
  }

  public function getDiariesCountAttribute()
  {
    return $this->diaries()->count();
  }
  public function getCounselingsCountAttribute()
  {
    return $this->counselings()->count();
  }

  public function getMenusCountAttribute()
  {
    return $this->menus()->count();
  }

  public function getStuffsCountAttribute()
  {
    return $this->stuffs()->count();
  }

  public function getUserNameAttribute()
  {
    return $this->users()->first()->name;
  }

  public function getEmailAttribute()
  {
    return $this->users()->first()->email;
  }

  public function getRoleAttribute()
  {
    return $this->users()->first()->role;
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

  public function getAddressAttribute()
  {
    $pref = $this->pref()->count() ? $this->pref()->first()->name: '';
    $city = $this->city()->count() ? $this->city()->first()->name: '';
    $town = $this->town()->count() ? $this->town()->first()->name: '';

    return "{$pref}{$city}{$town}{$this->addr02}";
  }

  public function getAddr01Attribute()
  {
    $pref = $this->pref()->count() ? $this->pref()->first()->name: '';
    $city = $this->city()->count() ? $this->city()->first()->name: '';
    $town = $this->town()->count() ? $this->town()->first()->name: '';

    return "{$pref}{$city}{$town}";
  }

  public function getWorkTimesAttribute() {
    $result = DayInfo::leftJoin('clinic_day_infos', function ($join) {
                  $join->on('day_infos.id', '=', 'clinic_day_infos.day_info_id')
                      ->where('clinic_day_infos.clinic_id', $this->id);
              })
              ->orderBy('day_infos.order')
              ->select(
                'day_infos.name as weekday',
                'clinic_day_infos.type',
                'clinic_day_infos.start_time',
                'clinic_day_infos.end_time',
              )
              ->get();

    return $result;
  }

  public function user()
  {
    return $this->belongsTo(User::class);
  }

  public function users()
  {
    return $this->belongsTo(User::class, 'user_id');
  }

  public function images()
  {
    return $this->morphMany(Attachment::class, 'attachable');
  }

  public function memos()
  {
    return $this->belongsToMany(Memo::class);
  }

  public function cases()
  {
    return $this->hasMany(TreatCase::class);
  }

  public function pref()
  {
    return $this->belongsTo(Pref::class);
  }

  public function city()
  {
    return $this->belongsTo(City::class);
  }

  public function town()
  {
    return $this->belongsTo(Town::class);
  }

  public function menus()
  {
    return $this->hasMany(Menu::class);
  }

  // public function menus_limit2()
  // {
  //   return $this->hasMany(Menu::class)
  //     ->orderby('menus.updated_at', 'desc')
  //     ->limit(2);
  // }

  public function stuffs()
  {
    return $this->hasMany(Stuff::class);
  }

  // public function stuffs_limit4()
  // {
  //   return $this->hasMany(Stuff::class)
  //     ->orderby('stuffs.updated_at', 'desc')
  //     ->limit(4);
  // }

  public function doctors()
  {
    return $this->hasMany(Doctor::class);
  }
  public function favoriters()
  {
    return $this->morphToMany(Patient::class, 'favoriable', 'favorites');
  }

  public function diaries() {
    return $this->hasMany(Diary::class);
  }

  public function diaries_limit2() {
    return $this->hasMany(Diary::class)
      ->orderby('diaries.updated_at', 'desc')
      ->limit(2);
  }

  public function counselings() {
    return $this->hasMany(CounselingReport::class);
  }

  public function counselings_limit2() {
    return $this->hasMany(CounselingReport::class)
      ->orderby('counseling_reports.updated_at', 'desc')
      ->limit(2);
  }
}
