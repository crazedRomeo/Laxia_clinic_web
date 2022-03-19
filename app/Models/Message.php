<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Message extends Model
{
  /**
   * The table associated with the model.
   *
   * @var string
   */
  protected $table = 'messages';

  /**
   * The attributes that are mass assignable.
   *
   * @var array
   */
  protected $fillable = [
    'mailbox_id',
    'user_id',
    'message',
    'is_file'
  ];

  protected $appends = [
    'is_mine',
    'file_thumb_url',
    'display_time_lable',
  ];

  public function getIsMineAttribute()
  {
    $currentUser = auth()->guard('api')->user();
    return $currentUser && $currentUser->id == $this->user_id;
  }

  public function getFileThumbUrlAttribute()
  {
    if ($this->is_file) {
      return "/storage" . $this->message;
    }
    return '';
  }

  public function getDisplayTimeLableAttribute() {
    return date('H:i', strtotime($this->created_at));
  }

  public function mailbox()
  {
    return $this->belongsTo(Mailbox::class);
  }
  
  public function sender()
  {
    return $this->belongsTo(User::class, 'user_id', 'id');
  }
}
