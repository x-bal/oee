<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class WorkingTimeModel extends Model
{
    use HasFactory;
    protected $table = 'mworkingtime';
    protected $fillable = [
        'txtshiftname',
        'tmstart',
        'tmfinish',
        'intinterval',
    ];
}
