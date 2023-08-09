<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OeeModel extends Model
{
    use HasFactory;
    protected $table = 'oee';
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
        'okp_packing',
        'production_code',
        'expired_date',
        'finish_good',
        'qc_sample',
        'category_rework',
        'rework',
        'reject',
        'reject_pcs',
        'category_reject',
        'waiting_tech',
        'tech_name',
        'repair_problem',
        'trial_time',
        'bas_com',
        'category_br',
        'category_ampm',
        'jumlah_manpower'
    ];
    public $timestamps = false;
}
