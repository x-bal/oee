<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LineProcess extends Model
{
    use HasFactory;
    protected $table = 'mline';
    protected $fillable = ['txtlinename'];
    public static $rules = [
        'txtlinename' => 'required',
    ];
}
