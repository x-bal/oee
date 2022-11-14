<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;
use Salman\Mqtt\MqttClass\Mqtt;
use Illuminate\Support\Facades\DB;

class MqttSubscribe implements ShouldQueue
{
    use Dispatchable, InteractsWithSockets, Queueable, SerializesModels;
    public $timeout = 0;

    /**
     * Create a new event instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    public function handle()
    {
        $mqtt = new Mqtt();
        $client_id = rand(10, 9999);
        $topic = 'test/topic/mesin';
        $mqtt->ConnectAndSubscribe($topic, function($topic, $msg){
            echo "Msg Received: \n";
            echo "Topic: {$topic}\n\n";
            echo "\t$msg\n\n";
            DB::table('loghistory')->insert(['status' => $msg]);
        }, $client_id);
    }
    /**
     * Get the channels the event should broadcast on.
     *
     * @return \Illuminate\Broadcasting\Channel|array
     */
    public function broadcastOn()
    {
        return new PrivateChannel('channel-name');
    }
}
