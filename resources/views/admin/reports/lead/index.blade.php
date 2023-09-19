@extends('layouts.app')

@section('page-title')
    <div class="row bg-title">
        <!-- .page title -->
        <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
            <h4 class="page-title"><i class="{{ $pageIcon }}"></i> @lang($pageTitle)</h4>
        </div>
        <!-- /.page title -->
        <!-- .breadcrumb -->
        <div class="col-lg-9 col-sm-8 col-md-8 col-xs-12">
            <ol class="breadcrumb">
                <li><a href="{{ route('admin.dashboard') }}">@lang('app.menu.home')</a></li>
                <li class="active">@lang($pageTitle)</li>
            </ol>
        </div>
        <!-- /.breadcrumb -->
    </div>
@endsection
@section('content')

    <div class="row">
        <div class="white-box">
            <div class="row" style="display: block;" id="ticket-filters">
                <form action="{{ url('admin/reports/single-report') }}" method="get">
                    <div class="col-md-4">
                        <h5>@lang('app.selectDateRange')</h5>
                        <div class="input-daterange input-group m-t-5" id="date-range">
                            <input type="date" id="start_date" name="start_date" value="{{ date('Y-m-d') }}" class="form-control">
                            <span class="input-group-addon bg-info b-0 text-white">@lang('app.to')</span>
                            <input type="date" id="end_date" name="end_date" value="{{ date('Y-m-d') }}" class="form-control">
                        </div>
                    </div>
                    <div class="col-md-4" style="margin-right:3px;">
                        <h5>@lang('modules.tickets.chooseAgents')</h5>
                        <div class="form-group">
                            <select class="select2 form-control" id="assignedTo" name="assignedTo">
                                <option value="all">@lang('app.all')</option>
                                @foreach($leadAgents as $emp)
                                    <option value="{{ $emp->id }}">{{ ucwords($emp->user->name) }} @if($emp->user->id == $user->id)
                                            (YOU) @endif</option>
                                @endforeach
                            </select>
                        </div>
                      
                    </div>
                   
                    <div class="col-md-4">
                        <div class="form-group m-t-10">
                            <label class="control-label col-xs-12">&nbsp;</label>
                            <button type="submit"  class="btn btn-success btn-sm"><i class="fa fa-check"></i> @lang('app.apply')</button>
                            <button type="button" id="reset-filters" class="btn btn-inverse btn-sm"><i class="fa fa-refresh"></i> @lang('app.reset')</button>
                            <button type="button" class="btn btn-default btn-sm toggle-filter"><i class="fa fa-close"></i> @lang('app.close')</button>
                        </div>
                    </div>
                </form>
            </div>

           
        </div>
    </div>
    <!-- .row -->

@endsection