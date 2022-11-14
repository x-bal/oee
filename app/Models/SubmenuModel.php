<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SubmenuModel extends Model
{
    use HasFactory;
    protected $table = 'submenu';
    protected $fillable = [
        'menu_id',
        'txturl',
        'txttitle',
        'txtroute',
        'txticon',
    ];
    public function menu()
    {
        return $this->belongsTo('App\Models\MenuModel');
    }
}
