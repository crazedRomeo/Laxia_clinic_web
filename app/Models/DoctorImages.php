<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DoctorImages extends Model
{
  /**
   * The table associated with the model.
   *
   * @var string
   */
  protected $table = 'doctor_images';

  /**
   * The attributes that are mass assignable.
   *
   * @var array
   */
  protected $fillable = [
    'doctor_id',
    'photo'
  ];

  protected $hidden = [
    'doctor_id',
    'updated_at',
    'created_at',
  ];
}
