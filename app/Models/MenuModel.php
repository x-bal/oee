<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MenuModel extends Model
{
    use HasFactory;
    protected $table = 'menu';
    protected $fillable = ['txticon', 'txttitle', 'txturl', 'txtroute'];
    public function submenu()
    {
        return $this->hasMany('App\Models\SubmenuModel', 'menu_id');
    }
}
