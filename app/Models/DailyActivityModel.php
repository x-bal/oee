<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DailyActivityModel extends Model
{
    use HasFactory;
    protected $table = 'tr_dailyactivity';
    protected $fillable = ['working_id', 'activity_id', 'tmstart', 'tmfinish'];
}
