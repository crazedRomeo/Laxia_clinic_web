<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ClinicDayInfo extends Model
{
  /**
   * The table associated with the model.
   *
   * @var string
   */
  protected $table = 'clinic_day_infos';

  protected $fillable = [
    'clinit_id',
    'day_info_id',
    'type',
    'start_time',
    'end_time'
  ];
}
