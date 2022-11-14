<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Machine extends Model
{
    use HasFactory;
    protected $table = 'mmachines';
    protected $fillable = ['line_id', 'txtmachinename', 'txtpicture'];
    public static $rules = [
        'line_id' => 'required',
        'txtmachinename' => 'required',
    ];
}
