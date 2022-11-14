<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class KpiModel extends Model
{
    use HasFactory;
    protected $table = 'mkpi';
    protected $fillable = [
        'txtyear', 'poe'
    ];
}
