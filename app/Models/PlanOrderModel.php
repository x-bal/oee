<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PlanOrderModel extends Model
{
    use HasFactory;
    protected $table = 'mplanorder';
    protected $fillable = ['line_id', 'product_id', 'txtbatchcode', 'intstatus', 'inttarget'];
}
