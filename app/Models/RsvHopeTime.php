<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RsvHopeTime extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'rsv_hope_times';
  
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
      'reservation_id',
      'date',
      'start_time',
      'end_time',
    ];
  
    protected $appends = [
      'hope_time',
      'start_time_str',
    ];

    public function getHopeTimeAttribute()
    {
      return substr($this->start_time, 0, 5) . ' ~ ' . substr($this->end_time, 0, 5);
    }
    
    public function getStartTimeStrAttribute()
    {
      $weekday_str_arr = ['月', '火', '水', '木', '金', '土', '日'];
      $weekday = $weekday_str_arr[(int)date('N', strtotime($this->date . ' ' . $this->start_time)) - 1];

      return date('Y年m月d日('. $weekday .') H:i', strtotime($this->date . ' ' . $this->start_time));
    }
}
