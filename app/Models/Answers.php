<?php

namespace App\Models;

use App\Models\Doctor;
use App\Models\AnswerImages;
use Illuminate\Database\Eloquent\Model;

class Answers extends Model
{
  /**
   * The table associated with the model.
   *
   * @var string
   */
  protected $table = 'answers';

  /**
   * The attributes that are mass assignable.
   *
   * @var array
   */
  protected $fillable = [
    'question_id',
    'doctor_id',
    'answer',
  ];

  protected $hidden = [
    'updated_at',
    // 'created_at',
  ];

  protected $appends = [
    'doctor',
    'photos',
  ];

  public function doctor()
  {
    return $this->belongsTo(Doctor::class);
  }

  public function getDoctorAttribute()
  {
    return $this->doctor()->first();
  }

  public function answerImages()
  {
    return $this->hasMany(AnswerImages::class, 'answer_id', 'id');
  }

  public function getPhotosAttribute()
  {
    return $this->answerImages()->get();
  }
}
