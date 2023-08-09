<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $table = 'musers';
    protected $fillable = [
        'line_id',
        'txtname',
        'txtusername',
        'txtinitial',
        'txtqrcode',
        'level_id',
        'password',
        'txtphoto',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    // protected $casts = [
    //     'email_verified_at' => 'datetime',
    // ];
    public static function rules($id = false){
        if ($id) {
            return [
                'txtname' => 'required',
                'txtusername' => 'required|unique:musers,txtusername,' . $id,
                'txtinitial' => 'required|unique:musers,txtinitial,' . $id,
                'level_id' => 'required',
                'password' => 'required',
            ];
        } else {
            return [
                'txtname' => 'required',
                'txtusername' => 'required|unique:musers,txtusername',
                'txtinitial' => 'required|unique:musers,txtinitial',
                'level_id' => 'required',
                'password' => 'required',
            ];
        }
    }
}
