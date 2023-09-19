<link rel="stylesheet" href="{{ asset('plugins/bower_components/bootstrap-datepicker/bootstrap-datepicker.min.css') }}">
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title"> <i class="fa fa-plus"></i>  @lang('app.targetcurrent')</h4>
</div>
<div class="modal-body">
    
    <form action="{{ route('admin.employee-tragetcurrent.store') }}" method="post" class="form-horizontal">
        @csrf
    <input type="hidden" name="user_id" value="{{ $employeeID }}">
    <div class="form-body">
        <div class="row">
            
                <div class="col-md-12">
                    <div id="dateBox" class="form-group ">
                        <input class="form-control" autocomplete="off" id="date" name="date" type="date" value="" placeholder="@lang('app.date')"/>
                        <div id="errorDate"></div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div id="dateBox" class="form-group ">
                        <input class="form-control" autocomplete="off" id="total" name="total" type="text" value="" placeholder="@lang('app.total')"/>
                        <div id="errorDate"></div>
                    </div>
                </div>
        </div>
        <!--/row-->
    </div>
    <div class="modal-footer">
    <button type="button" class="btn btn-white waves-effect" data-dismiss="modal">Close</button>
    <button type="submit" onclick="storeTragetCurrent()" class="btn btn-info save-event waves-effect waves-light"><i class="fa fa-check"></i> @lang('app.save')
    </button>
</div>
</form>
  
</div>

<script src="{{ asset('plugins/bower_components/bootstrap-datepicker/bootstrap-datepicker.min.js') }}"></script>


