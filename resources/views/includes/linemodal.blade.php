<!-- #modal-dialog -->
<div class="modal fade" id="selectLine" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">Select Line</h4>
      </div>
      <div class="modal-body">
        <form action="{{ route('dashboard.post.line') }}" method="post" id="lineForm">
        @csrf
        <div class="mb-3">
            <label for="Line">Line* :</label>
            <select name="line_id" id="LineSelect" class="form-select">
                @php
                    $line_id = DB::table('line_users')->where('user_id', Auth::user()->id)->pluck('line_id')->toArray();
                    $lines = App\Models\LineProcess::whereIn('id', $line_id)->get();
                @endphp
                <option disabled selected>Select Line</option>
                @foreach ($lines as $item)
                    <option value="{{ $item->id }}">{{ $item->txtlinename }}</option>
                @endforeach
            </select>
        </div>
        @if (in_array(Auth::user()->level_id, [7, 8]))
        <div class="mb-3">
            <label for="Leader">Leader* :</label>
            <select name="leader_id" id="LeaderSelect" class="form-select">
                @php
                    $users = App\Models\User::whereIn('level_id', [6, 10])->get();
                @endphp
                <option disabled selected>Select Leader</option>
                @foreach ($users as $item)
                    <option value="{{ $item->id }}">{{ $item->txtname }}</option>
                @endforeach
            </select>
        </div>
        @endif
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-success">Save</button>
      </div>
    </form>
    </div>
  </div>
</div>
<script>
    let line_ses = "{{ session()->has('line') }}";
    let level = "{{ App\Models\LevelModel::where('id', Auth::user()->level_id)->first()->intsessline }}";
    function gritter(title, text){
            let className = (title == 'success'?'bg-success':'bg-danger');
            $.gritter.add({
                title: title,
                text: '<p class="text-light">'+text+'</p>',
                class_name: className,
                time: 1000,
            });
        }
    $(document).ready(function(){
        if (!line_ses) {
            if (level == 1) {
                $('#selectLine').modal('show');
            }
        }
        $('#lineForm').on('submit', function(e){
            e.preventDefault();
            $.ajax({
                url: "{{ route('dashboard.post.line') }}",
                type: "POST",
                data: $(this).serialize(),
                dataType: "JSON",
                success: function(response){
                    $('#selectLine').modal('hide');
                    gritter(response.status, response.message, 'bg-success');
                }
            })
        })
    })
</script>
