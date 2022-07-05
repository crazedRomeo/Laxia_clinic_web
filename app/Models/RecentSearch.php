<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Patient;
use App\Models\Search;
class RecentSearch extends Model
{
  /**
   * The table associated with the model.
   *
   * @var string
   */
  protected $table = 'recent_search';

  /**
   * The attributes that are mass assignable.
   *
   * @var array
   */
  protected $fillable = [
  ];

  protected $hidden = [
    'id',
    'search_id',
    'patient_id',
    'updated_at',
    'created_at',
  ];
  protected $appends=[
    'search'
  ];
  public function  patient() {
    return $this->belongsTo(Patient::class);
  }
  public function  search() {
    return $this->belongsTo(Search::class,'search_id');
  }
  public function getSearchAttribute()
  {
    return  $this->search()->first();
  }
}
