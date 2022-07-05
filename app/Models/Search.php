<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\RecentSearch;

class Search extends Model
{
  /**
   * The table associated with the model.
   *
   * @var string
   */
  protected $table = 'search';

  /**
   * The attributes that are mass assignable.
   *
   * @var array
   */
  protected $fillable = [
    'text',
    'followcount',
  ];

  protected $hidden = [
    'id',
    'updated_at',
    'created_at',
  ];
  public function recentsearch(){
    return $this->hasMany(RecentSearch::class);
  }
}
