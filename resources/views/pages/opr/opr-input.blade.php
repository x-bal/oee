@extends('layouts.default')

@section('title', 'Dashboard')

@push('css')
    <link href="/assets/plugins/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/datatables.net-buttons-bs5/css/buttons.bootstrap5.min.css" rel="stylesheet" />
    <link href="/assets/plugins/jvectormap-next/jquery-jvectormap.css" rel="stylesheet" />
    <link href="/assets/plugins/simple-calendar/dist/simple-calendar.css" rel="stylesheet" />
    <link href="/assets/plugins/gritter/css/jquery.gritter.css" rel="stylesheet" />
    <link href="/assets/plugins/nvd3/build/nv.d3.css" rel="stylesheet" />
    <link href="/assets/plugins/select2/dist/css/select2.min.css" rel="stylesheet" />
@endpush

@section('content')
    <!-- BEGIN breadcrumb -->
    <ol class="breadcrumb float-xl-end">
        <li class="breadcrumb-item"><a href="javascript:;">Home</a></li>
        <li class="breadcrumb-item active">Dashboard</li>
    </ol>
    <!-- END breadcrumb -->
    <!-- BEGIN page-header -->
    <h1 class="page-header">PT Dharma Polimetal <br> <small>OEES || Overall Equipment Effectiveness System</small>
    </h1>
    <!-- END page-header -->
    <!-- BEGIN row -->
    <div class="row">
        <div class="col-12">
            <div class="panel panel-inverse">
                {{-- <div class="panel-heading">
                  <h4 class="panel-title">Panel Title</h4>
                  <div class="panel-heading-btn">
                    <a href="#" class="btn btn-xs btn-icon btn-default" data-toggle="panel-expand">
                      <i class="fa fa-expand"></i>
                    </a>
                  </div>
                </div> --}}
                <div class="panel-body">
                    <div class="row">
                        <div class="col-3">
                            <div class="table-responsive">
                                <table>
                                    <tr>
                                        <td>Product Name</td>
                                        <td>:</td>
                                        <td class="productname"><b>PRODUK</b></td>
                                    </tr>
                                    <tr>
                                        <td>Size</td>
                                        <td>:</td>
                                        <td><b>SIZE</b></td>
                                    </tr>
                                    <tr>
                                        <td>Line Process</td>
                                        <td>:</td>
                                        <td class="linename"></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="table-responsive">
                                <table>
                                    <tr>
                                        <td>Batch Order</td>
                                        <td>:</td>
                                        <td class="batchcode"></td>
                                    </tr>
                                    <tr>
                                        <td>Production Code</td>
                                        <td>:</td>
                                        <td><b>DUMMY DATA</b></td>
                                    </tr>
                                    <tr>
                                        <td>Expire Date</td>
                                        <td>:</td>
                                        <td><b>DUMMY DATA</b></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="table-responsive">
                                <table>
                                    <tr>
                                        <td>Production Release</td>
                                        <td>:</td>
                                        <td class="is_released"></td>
                                    </tr>
                                    <tr>
                                        <td>Operator</td>
                                        <td>:</td>
                                        <td><b>OPR</b></td>
                                    </tr>
                                    <tr>
                                        <td>Standar Speed</td>
                                        <td>:</td>
                                        <td class="stdspeed"></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="note note-success">
                                <div class="note-content text-light">
                                    <h5>Active</h5>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-9">
                            <div class="panel border">
                                <div class="panel-heading">
                                    <h4 class="panel-title">Input Downtime</h4>
                                </div>
                                <hr>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="table-responsive">
                                            <table id="daTable" class="table table-striped table-bordered align-middle">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>START</th>
                                                        <th>FINISH</th>
                                                        <th>DURATION</th>
                                                        <th>ACTIVITY</th>
                                                        <th>ACTION</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="row">
                                <div class="panel border">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">Production Rate</h4>
                                    </div>
                                    <div class="panel-body">
                                        <div class="widget-chart-content">
                                            <canvas class="widget-chart-full-width" id="RateChart"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-6">
                                    <div class="panel border">
                                        <div class="panel-heading bg-success text-white">
                                            <h3>Good</h3>
                                        </div>
                                        <div class="panel-body text-success">
                                            <h2 class="text-center">0</h2>
                                            <h5 class="text-end">pcs</h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="panel border">
                                        <div class="panel-heading bg-danger text-white">
                                            <h3>Reject</h3>
                                        </div>
                                        <div class="panel-body text-danger">
                                            <h2 class="text-center">0</h2>
                                            <h5 class="text-end">pcs</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END row -->
    <!-- #modal-dialog -->
    <div class="modal fade" id="oeeModal" role="dialog">
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-success text-light">
                <h4 class="modal-title">Modal Dialog</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-hidden="true"></button>
            </div>
            <div class="modal-body">
            <form action="" method="post" data-parsley-validate="true">
                @csrf
                <div class="mb-3">
                    <label for="Activity">Activity* :</label>
                    <select name="activity_id" id="Activity" class="select2 form-control" data-parsley-required="true">
                    </select>
                </div>
                <div class="mb-3">
                    <label for="Start">Start* :</label>
                    <input type="text" id="Start" name="tmstart" class="form-control" placeholder="Enter Start Time" disabled/>
                </div>
                <div class="mb-3">
                    <label for="Finish">Finish* :</label>
                    <input type="text" id="Finish" name="tmfinish" class="form-control" placeholder="Enter Finish Time" disabled/>
                </div>
                <div class="mb-3">
                    <label for="Duration">Duration (minutes)* :</label>
                    <input type="text" id="Duration" name="intduration" class="form-control" placeholder="Enter Duration Time" disabled/>
                </div>
                <div class="mb-3">
                    <label for="Waiting">Waiting Technician (minutes) :</label>
                    <input type="number" id="Waiting" name="waiting_tech" class="form-control" placeholder="Waiting Technician Time"/>
                </div>
                <div class="mb-3">
                    <label for="Repair">Repair Time (minutes) :</label>
                    <input type="number" id="Repair" name="repair_problem" class="form-control" placeholder="Repair Time"/>
                </div>
                <div class="mb-3">
                    <label for="Trial">Trial Time (minutes) :</label>
                    <input type="number" id="Trial" name="trial_time" class="form-control" placeholder="Trial Time"/>
                </div>
                <div class="mb-3">
                    <label for="TechName">Technician Name :</label>
                    <input type="text" id="TechName" name="tech_name" class="form-control" placeholder="Technician Name"/>
                </div>
                <div class="mb-3">
                    <label for="BasCom">Basic Competency :</label>
                    <select name="bascom" id="BasCom" class="form-control" data-parsley-required="true">
                        <option value=""></option>
                        @foreach ($bascom as $key => $val)
                            <option value="{{ $val }}">{{ $val }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="mb-3">
                    <label for="CategoryBR">Category BreakDown :</label>
                    <select name="catbr" id="CategoryBR" class="form-control" data-parsley-required="true">
                        <option value=""></option>
                        @foreach ($catbr as $key => $val)
                            <option value="{{ $val }}">{{ $val }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="mb-3">
                    <label for="CategoryAm">Category AM/PM :</label>
                    <select name="catampm" id="CategoryAm" class="form-control" data-parsley-required="true">
                        <option value=""></option>
                        <option value="AM">AM</option>
                        <option value="PM">PM</option>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <a href="javascript:;" class="btn btn-white" data-bs-dismiss="modal">Close</a>
                <button type="submit" class="btn btn-success">Save</button>
            </div>
            </form>
        </div>
        </div>
    </div>
    <!-- End-Modal-Dialog -->

    @endsection
    @push('scripts')
        <script src="/assets/plugins/d3/d3.min.js"></script>
        <script src="/assets/plugins/nvd3/build/nv.d3.js"></script>
        <script src="/assets/plugins/jvectormap-next/jquery-jvectormap.min.js"></script>
        <script src="/assets/plugins/jvectormap-next/jquery-jvectormap-world-mill.js"></script>
        <script src="/assets/plugins/simple-calendar/dist/jquery.simple-calendar.min.js"></script>
        <script src="/assets/plugins/gritter/js/jquery.gritter.js"></script>
        <script src="/assets/plugins/chart.js/dist/chart.min.js"></script>
        <script src="/assets/plugins/datatables.net/js/jquery.dataTables.min.js"></script>
        <script src="/assets/plugins/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
        <script src="/assets/plugins/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
        <script src="/assets/plugins/datatables.net-responsive-bs5/js/responsive.bootstrap5.min.js"></script>
        <script src="/assets/plugins/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
        <script src="/assets/plugins/datatables.net-buttons-bs5/js/buttons.bootstrap5.min.js"></script>
        <script src="/assets/plugins/datatables.net-buttons/js/buttons.colVis.min.js"></script>
        <script src="/assets/plugins/datatables.net-buttons/js/buttons.flash.min.js"></script>
        <script src="/assets/plugins/datatables.net-buttons/js/buttons.html5.min.js"></script>
        <script src="/assets/plugins/datatables.net-buttons/js/buttons.print.min.js"></script>
        <script src="/assets/plugins/pdfmake/build/pdfmake.min.js"></script>
        <script src="/assets/plugins/pdfmake/build/vfs_fonts.js"></script>
        <script src="/assets/plugins/jszip/dist/jszip.min.js"></script>
        <script src="/assets/plugins/select2/dist/js/select2.min.js"></script>
        <script src="{{ asset('assets/js/paho.mqtt.js') }}" type="text/javascript"></script>
        <script>
            let url = "";
            let activityUrl = "{{ route('checker.list.activity') }}";
            function getUrl(){
                return url;
            }
            var daTable = $('#daTable').DataTable({
                ajax: "{{ route('input.opr.index') }}",
                processing: true,
                serverSide: true,
                columns: [
                    {data: 'DT_RowIndex'},
                    {data: 'start'},
                    {data: 'finish'},
                    {data: 'lamakejadian'},
                    {data: 'txtactivityname'},
                    {data: 'action'}
                ]
            });
            function reloadTable() {
                daTable.ajax.reload(null, false);
            }
            function getDetails(){
                $.get("{{ route('checker.details.get') }}", function(response){
                    if (response.planorder != null) {
                        $('td.productname').html('<b>'+response.planorder.txtproductname+'</b>');
                        $('td.linename').html('<b>'+response.planorder.txtlinename+'</b>');
                        $('td.batchcode').html('<b>'+response.planorder.txtbatchcode+'</b>');
                        $('td.stdspeed').html('<b>'+response.planorder.floatstdspeed+' pcs/minutes</b>');
                        $('td.is_released').html('<b>'+response.planorder.is_released+'</b>');
                    }
                })
            }
            function OeeModal(id){
                let oeeUrl = "{{ route('checker.detail.oee', ':id') }}";
                oeeUrl = oeeUrl.replace(':id', id);
                url = "{{ route('checker.oee.update', ':id') }}";
                url = url.replace(':id', id);
                $.get(oeeUrl, function(response){
                    $('.modal-header h4').text('Input Oee');
                    $('#oeeModal').modal('show');
                    $('input[name="tmstart"]').val(response.oee.start);
                    $('input[name="tmfinish"]').val(response.oee.finish);
                    $('input[name="intduration"]').val(response.oee.lamakejadian/60);
                })
            }
            function getActivityList(){
                let wrapper = $('select[name="activity_id"]');
                let opt = '';
                wrapper.find('option').remove();
                $.get(activityUrl, function(response){
                    let activity = response.activity;
                    $.each(activity, function(i, val){
                        opt += '<option value="'+activity[i].id+'">'+activity[i].txtactivitycode+' - '+ activity[i].txtdescription +'</option>';
                    })
                    wrapper.append(opt).trigger('change');
                })
            }
            let pahoConfig = {
                hostname: "{{ $broker->txthost }}", //The hostname is the url, under which your FROST-Server resides.
                port: "{{ $broker->intwsport }}", //The port number is the WebSocket-Port,
                clientId: "ClientId-75tug6rkbbjawdhao876dawdas" //Should be unique for every of your client connections.
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
                reloadTable();
                getDetails();
            }
            function gritter(title, text, status){
                $.gritter.add({
                    title: title,
                    text: '<p class="text-light">'+text+'</p>',
                    class_name: status,
                    time: 1000,
                });
            }
            $(document).ready(function() {
                getActivityList();
                $('select[name="activity_id"]').select2({
                    dropdownParent: $('#oeeModal'),
                    placeholder: "Select Activity",
                    allowClear: true
                });
                $('#CategoryBR').select2({
                    dropdownParent: $('#oeeModal'),
                    placeholder: "Select Category Breakdown",
                    allowClear: true
                });
                $('#BasCom').select2({
                    dropdownParent: $('#oeeModal'),
                    placeholder: "Select Basic Competency",
                    allowClear: true
                });
                getDetails();
                client.connect({
                    onSuccess: onConnect
                });
                $('.modal-body form').on('submit', function(e){
                    e.preventDefault();
                    let orFail = '';
                    $.ajax({
                        url: getUrl(),
                        method: "PUT",
                        data: $(this).serialize(),
                        dataType: "JSON",
                        success: function(response){
                            $('#oeeModal').modal('hide');
                            orFail = (response.status == 'success'?'bg-success':'bg-danger');
                            daTable.ajax.reload(null, false);
                            gritter(response.status, response.message, orFail);
                        }
                    })
                })
            })
        </script>
    @endpush
