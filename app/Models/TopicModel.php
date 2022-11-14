<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TopicModel extends Model
{
    use HasFactory;
    protected $table = 'mtopic';
    protected $fillable = [
        'broker_id',
        'machine_id',
        'txttopiccounting',
        'txttopicstatus',
        'txttopicreject',
    ];
}
