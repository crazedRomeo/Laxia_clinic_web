<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Menu;

class MenuProcess extends Model
{
  /**
   * The table associated with the model.
   *
   * @var string
   */
  protected $table = 'menu_process';

  /**
   * The attributes that are mass assignable.
   *
   * @var array
   */
  protected $fillable = [
    'menu_id',
    'title',
    'period'
  ];

  protected $hidden = [
    'id',
    'updated_at',
    'created_at',
  ];
  public function Menus(){
    return $this->hasMany(Menu::class);
  }
}
