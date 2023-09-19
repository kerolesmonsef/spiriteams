<link rel="stylesheet" href="{{ asset('plugins/bower_components/bootstrap-datepicker/bootstrap-datepicker.min.css') }}">
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title"> <i class="fa fa-plus"></i>  @lang('app.target')</h4>
</div>
<div class="modal-body">
    
    <form action="{{ route('admin.employee-traget.store') }}" method="post" class="form-horizontal">
        @csrf
    <input type="hidden" name="user_id" value="{{ $employeeID }}">
    <div class="form-body">
        <div class="row">
            
                <div class="col-md-12">
                    <div id="dateBox" class="form-group ">
                        <input class="form-control" autocomplete="off" id="call_w" name="call_w" type="number" value="" placeholder="@lang('app.call_w')"/>
                        <div id="errorDate"></div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div id="dateBox" class="form-group ">
                        <input class="form-control" autocomplete="off" id="call_m" name="call_m" type="number" value="" placeholder="@lang('app.call_m')"/>
                        <div id="errorDate"></div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div id="dateBox" class="form-group ">
                        <input class="form-control" autocomplete="off" id="visits_w" name="visits_w" type="number" value="" placeholder="@lang('app.visits_w')"/>
                        <div id="errorDate"></div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div id="dateBox" class="form-group ">
                        <input class="form-control" autocomplete="off" id="visits_m" name="visits_m" type="number" value="" placeholder="@lang('app.visits_m')"/>
                        <div id="errorDate"></div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div id="dateBox" class="form-group ">
                        <input class="form-control" autocomplete="off" id="money" name="money" type="text" value="" placeholder="@lang('app.money')"/>
                        <div id="errorDate"></div>
                    </div>
                </div>
              
            
        </div>
        <!--/row-->
    </div>
    <div class="modal-footer">
    <button type="button" class="btn btn-white waves-effect" data-dismiss="modal">Close</button>
    <button type="submit" onclick="storeTraget()" class="btn btn-info save-event waves-effect waves-light"><i class="fa fa-check"></i> @lang('app.save')
    </button>
</div>
</form>
  
</div>

<script src="{{ asset('plugins/bower_components/bootstrap-datepicker/bootstrap-datepicker.min.js') }}"></script>

<script>

    // Store Holidays
    function storeTraget(){
        $('#dateBox').removeClass("has-error");
        $('#occasionBox').removeClass("has-error");
        $('#errorDate').html('');
        $('#errorOccasion').html('');
        $('.help-block').remove();
        var url = "{{ route('admin.employee-traget.store') }}";
        $.easyAjax({
            type: 'POST',
            url: url,
            container: '#add_traget_form',
            file: false,
            success: function (response) {
                if(response.status == 'success'){
                    $('#employeeTargetList').html(response.html);
                    $('#edit-column-form').modal('hide');
                }
            }
        });
    }

  $('#save-form').click(function () {
        $.easyAjax({
            url: '{{route('admin.leads.store')}}',
            container: '#createLead',
            type: "POST",
            redirect: true,
            data: $('#createLead').serialize()
        })
    });
</script>


