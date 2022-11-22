<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductModel extends Model
{
    use HasFactory;
    protected $table = 'mproduct';
    protected $fillable = [
        'line_id',
        'txtartcode',
        'txtproductcode',
        'txtproductname',
        'txtlinecode',
        'floatbatchsize',
        'floatstdspeed',
        'intpcskarton',
        'intnetfill',
        'txtcategory',
        'txtfocuscategory',
    ];
    // protected $fillable = [
    //     'line_id',
    //     'txtpartnumber',
    //     'txtpartcode',
    //     'txtpartname',
    //     'txtlinecode',
    //     'floatstdspeed',
    //     'intpcskanban',
    //     'txtpartimage',
    //     'route_id',
    // ];
}
