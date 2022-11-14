<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ActivityModel extends Model
{
    use HasFactory;
    protected $table = 'mactivitycode';
    protected $fillable = [
        'line_id',
        'txtcategory',
        'txtactivityname',
        'txtdescription',
    ];
    public static $rules = [
        'line_id' => 'required',
        'txtactivityname' => 'required',
        'txtcategory' => 'required',
    ];
}
