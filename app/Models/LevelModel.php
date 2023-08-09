<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LevelModel extends Model
{
    use HasFactory;
    protected $table = 'mlevels';
    protected $fillable = [
        'txtlevelname', 'intsessline'
    ];
}
