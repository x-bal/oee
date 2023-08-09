<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AssignModel extends Model
{
    use HasFactory;

    protected $table = 'massign_line';
    protected $fillable = [
        'line_id', 'user_id'
    ];
}
