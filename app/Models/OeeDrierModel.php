<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OeeDrierModel extends Model
{
    use HasFactory;
    protected $table = 'oee_drier';
    protected $fillable = [
        'line_id',
        'shift_id',
        'tanggal',
        'start',
        'finish',
        'lamakejadian',
        'activity_id',
        'remark',
        'operator',
        'produk_code',
        'produk',
        'okp_drier',
        'output_bin',
        'output_kg',
        'rework',
        'category_rework',
        'reject',
        'waiting_tech',
        'tech_name',
        'repair_problem',
        'trial_time',
        'bas_com',
        'category_br',
        'category_ampm',
        'jumlah_manpower',
    ];
    public $timestamps = false;
}
