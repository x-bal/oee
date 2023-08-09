<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DailyActivityModel extends Model
{
    use HasFactory;
    protected $table = 'mdailyactivities';
    protected $fillable = ['line_id', 'activity_id', 'tmstart', 'tmfinish'];

    public static function rules()
    {
        return [
            'line_id' => 'required',
            'activity_id' => 'required',
            'tmstart' => 'required',
            'tmfinish' => 'required',
        ];
    }
    public static function attributes()
    {
        return [
            'line_id' => 'Line Process',
            'activity_id' => 'Activity',
            'tmstart' => 'Start Time',
            'tmfinish' => 'Finish Time',
        ];
    }
}
