@extends('layouts.default')

@section('title', 'View Topic Results')

@push('css')
    <link href="/assets/plugins/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" />
    <link href="/assets/plugins/select2/dist/css/select2.min.css" rel="stylesheet" />
@endpush

@section('content')
    <div class="d-flex align-items-center mb-3">
        <div>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="javascript:;">Dashboard</a></li>
                <li class="breadcrumb-item active">View Topic Results</li>
            </ol>
            <h1 class="page-header mb-0">View Topic Results</h1>
        </div>
    </div>
    <!-- BEGIN panel -->
    <div class="panel panel-inverse">
        <!-- BEGIN panel-heading -->
        <div class="panel-heading">
            <h4 class="panel-title">Data Topic Results</h4>
            <div class="panel-heading-btn">
                <a href="javascript:;" class="btn btn-xs btn-icon btn-default" data-toggle="panel-expand"><i
                        class="fa fa-expand"></i></a>
                <a type="button" onclick="reloadTable()" class="btn btn-xs btn-icon btn-success"
                    data-toggle="panel-reload"><i class="fa fa-redo"></i></a>
                <a href="javascript:;" class="btn btn-xs btn-icon btn-warning" data-toggle="panel-collapse"><i
                        class="fa fa-minus"></i></a>
                <a href="javascript:;" class="btn btn-xs btn-icon btn-danger" data-toggle="panel-remove"><i
                        class="fa fa-times"></i></a>
            </div>
        </div>
        <!-- END panel-heading -->
        <!-- BEGIN panel-body -->
        <div class="panel-body">
            <div class="table-responsive">
                <table id="daTable" class="table table-striped table-bordered align-middle">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>MACHINE</th>
                            <th>BROKER</th>
                            <th>TOPIC</th>
                            <th>RETURN</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- END panel-body -->
    </div>
    <!-- END panel -->
@endsection

@push('scripts')
    <script src="/assets/plugins/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="/assets/plugins/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
    <script src="/assets/plugins/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="/assets/plugins/datatables.net-responsive-bs5/js/responsive.bootstrap5.min.js"></script>
    <script src="/assets/plugins/@highlightjs/cdn-assets/highlight.min.js"></script>
    <script src="/assets/js/demo/render.highlight.js"></script>
    <script src="/assets/plugins/parsleyjs/dist/parsley.min.js"></script>
    <script src="/assets/plugins/gritter/js/jquery.gritter.js"></script>
    <script src="/assets/plugins/sweetalert/dist/sweetalert.min.js"></script>
    <script src="/assets/plugins/select2/dist/js/select2.min.js"></script>
    <script src="{{ asset('assets/js/paho.mqtt.js') }}" type="text/javascript"></script>
    <script>
        let action = '';
        let method = '';
        var daTable = $('#daTable').DataTable({
            ajax: "{{ route('view.topic.result') }}",
            processing: true,
            serverSide: true,
            columns: [{
                    data: 'DT_RowIndex'
                },
                {
                    data: 'txtmachinename'
                },
                {
                    data: 'broker'
                },
                {
                    data: 'txttopic'
                },
                {
                    data: 'message'
                },
            ]
        });

        function getUrl() {
            return action;
        }

        function getMethod() {
            return method;
        }

        function reloadTable() {
            daTable.ajax.reload(null, false);
        }

        function replaceVal(response){
            $.ajax({
                url: "{{ route('view.topic.result.detail') }}",
                type: "POST",
                data: {
                    "_token": "{{ csrf_token() }}",
                    "topic": response.destinationName
                },
                dataType: "JSON",
                success: function(result){
                    console.log(result.data);
                    $('#daTable').find('#'+result.data.topic_id+'-'+result.data.txtname).html(response.payloadString);
                }
            })
        }

        function gritter(title, text, status) {
            $.gritter.add({
                title: title,
                text: '<p class="text-light">' + text + '</p>',
                class_name: status,
                time: 1000,
            });
        }
        let pahoConfig = {
            hostname: "{{ $broker->txthost }}", //The hostname is the url, under which your FROST-Server resides.
            port: "{{ $broker->intwsport }}", //The port number is the WebSocket-Port,
            clientId: "ClientId-75tug6rkbbjawdhaosh876" //Should be unique for every of your client connections.
        }
        client = new Paho.MQTT.Client(pahoConfig.hostname, Number(pahoConfig.port), pahoConfig.clientId);
        client.onConnectionLost = onConnectionLost;
        client.onMessageArrived = onMessageArrived;
        // called when the client connects
        function onConnect() {
            // Once a connection has been made, make a subscription and send a message.
            console.log("onConnect");
            let topics = @json($topics);
            $.each(topics, function(i, val){
                client.subscribe(topics[i].txttopic);
            })
            // message = new Paho.MQTT.Message("Hello");
            // message.destinationName = "World";
            // client.send(message);
        }
        // called when the client loses its connection
        function onConnectionLost(responseObject) {
            if (responseObject.errorCode !== 0) {
                console.log("onConnectionLost:" + responseObject.errorMessage);
            }
        }

        // called when a message arrives
        function onMessageArrived(message) {
            console.log("onMessageArrived:" + message.payloadString);
            replaceVal(message);
        }
        $(document).ready(function() {
            client.connect({
                onSuccess: onConnect
            });
        })
    </script>
@endpush
