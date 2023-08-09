<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ServerModel extends Model
{
    use HasFactory;
    protected $table = 'mbroker';
    protected $fillable = [
        'txthost',
        'intport',
        'intwsport',
        'txtusername',
        'txtpassword',
        'txtclientid',
        'intactive',
    ];
}
