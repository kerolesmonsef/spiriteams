@extends('layouts.member-app')

@section('page-title')
    <div class="row bg-title">
        <!-- .page title -->
        <div class="col-lg-6 col-md-4 col-sm-4 col-xs-12">
            <h4 class="page-title"><i class="{{ $pageIcon }}"></i> @lang($pageTitle)</h4>
        </div>
        <!-- /.page title -->
        <!-- .breadcrumb -->
        <div class="col-lg-6 col-sm-8 col-md-8 col-xs-12">
            <ol class="breadcrumb">
                <li><a href="{{ route('member.dashboard') }}">@lang('app.menu.home')</a></li>
                <li><a href="{{ route('member.leads.index') }}">@lang($pageTitle)</a></li>
                <li class="active">@lang('app.edit')</li>
            </ol>
        </div>
        <!-- /.breadcrumb -->
    </div>
@endsection

@push('head-script')
<link rel="stylesheet" href="{{ asset('plugins/bower_components/bootstrap-datepicker/bootstrap-datepicker.min.css') }}">
@endpush

@section('content')

    <div class="row">
        <div class="col-md-12">

            <div class="panel panel-inverse">
                <div class="panel-heading"> @lang('modules.lead.updateTitle')</div>
                <div class="panel-wrapper collapse in" aria-expanded="true">
                    <div class="panel-body">
                        {!! Form::open(['id'=>'updateLead','class'=>'ajax-form','method'=>'PUT']) !!}
                            <div class="form-body">
                                <h3 class="box-title">@lang('modules.lead.leadDetails')</h3>
                                <hr>
                                
                                <div class="row">
                                    <div class="col-md-1">
                                        <div class="form-group" style="margin-top: 23px">
                                        <select name="salutation" id="salutation" class="form-control">
                                            <option value="">--</option>
                                                <option value="mr" @if($lead->salutation == 'mr') selected @endif >@lang('app.mr')</option>
                                                <option value="mrs" @if($lead->salutation == 'mrs') selected @endif >@lang('app.mrs')</option>
                                        </select>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-5">
                                        <div class="form-group">
                                            <label class="required">@lang('modules.lead.clientName')</label>
                                            <input type="text" name="name" id="name" value="{{$lead->client_name}}"  class="form-control">
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label class="control-label">@lang('modules.lead.companyName')</label>
                                            <input type="text" id="company_name" name="company_name" value="{{$lead->company_name}}" class="form-control" >
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label class="control-label">@lang('modules.lead.website')</label>
                                            <input type="text" id="website" name="website" value="{{$lead->website}}" class="form-control">
                                        </div>
                                    </div>
                        
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>@lang('modules.lead.clientEmail')</label>
                                            <input type="email" name="email" id="email" value="{{$lead->client_email}}"  class="form-control">
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-4">
                                        <div class="form-group">
                                        <label>@lang('modules.lead.mobile')</label>
                                        <input type="tel" name="phone" id="phone" value="{{$lead->phone}}" class="form-control">
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label>@lang('modules.client.officePhoneNumber')</label>
                                            <input type="text" name="office" id="office" value="{{ $lead->office ?? '' }}" class="form-control">
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3 ">
                                        <div class="form-group">
                                            <label>@lang('modules.stripeCustomerAddress.city')</label>
                                            <input type="text" name="city" id="city" value="{{ $lead->city ?? '' }}" class="form-control">
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3 ">
                                        <div class="form-group">
                                            <label>@lang('modules.stripeCustomerAddress.state')</label>
                                            <input type="text" name="state" id="state" value="{{ $lead->state ?? '' }}" class="form-control">
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3 ">
                                        <div class="form-group">
                                            <label>@lang('modules.stripeCustomerAddress.country')</label>
                                            <input type="text" name="country" id="country" value="{{ $lead->country ?? '' }}"  class="form-control">
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-3 ">
                                        <div class="form-group">
                                            <label>@lang('modules.stripeCustomerAddress.postalCode')</label>
                                            <input type="text" name="postal_code" id="postalcode" value="{{ $lead->postal_code ?? '' }}"  class="form-control">
                                        </div>
                                    </div>
                                   
                            </div>
                                
                                <h3 class="box-title">@lang('modules.lead.MarketingDetails')</h3>
                                <hr>
                                
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="">@lang('modules.tickets.chooseAgents')</label>
                                            <select class="select2 form-control" data-placeholder="@lang('modules.tickets.chooseAgents')" id="agent_id" name="agent_id">
                                                <option value="">@lang('modules.tickets.chooseAgents')</option>
                                                @foreach($leadAgents as $emp)
                                                <option value="{{ $emp->id }}" @if($lead->agent_id == $emp->id) selected @endif>{{ ucwords($emp->user->name) }} @if($emp->user->id == $user->id)
                                                    (YOU) @endif</option>
                                                @endforeach
                                            </select>
                                        </div>
                                    </div>
                            
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="">@lang('modules.lead.leadSource')</label>
                                            <select class="select2 form-control" data-placeholder="@lang('modules.lead.leadSource')" id="source_id" name="source_id">
                                                <option value="">@lang('modules.lead.leadSource')</option>
                                                @foreach($sources as $source)
                                                      <option value="{{ $source->id }}" @if($lead->source_id == $source->id) selected @endif>{{ ucwords($source->type) }}</option>
                                                @endforeach
                                            </select>
                                        </div>
                                    </div>
                            
                                    <div class="col-md-3">
                                        <div class="form-group">
                                            <label for="">@lang('app.status')</label>
                                            <select class="select2 form-control" data-placeholder="@lang('app.status')" id="status_id" name="status_id">
                                                @forelse($status as $sts)
                                                    <option @if($lead->status_id == $sts->id) selected @endif value="{{ $sts->id }}"> {{ $sts->type }}</option>
                                                @empty
                                
                                                @endforelse
                                            </select>
                                        </div>
                                    </div>
                                   
                                    <div class="col-md-3 ">
                                        <div class="form-group" style="margin-top: 7px;">
                                            <label>@lang('modules.lead.leadCategory')</label>
                                            <select class="select2 form-control" id="category_id" name="category_id" data-style="form-control">
                                                <option value="">@lang('messages.pleaseSelectCategory')</option>
                                                @forelse($categories as $category)
                                                <option value="{{ $category->id }}" @if($lead->category_id == $category->id) selected @endif>{{ ucwords($category->category_name) }}</option>
                                                @empty
                                                <option value="">@lang('messages.noCategoryAdded')</option>
                                                @endforelse
                                            </select>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>@lang('app.lead') @lang('app.value')</label>
                                            <input type="number" min="0" value="0" name="value" id="value" class="form-control">
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label>@lang('app.next_follow_up')</label>
                                            <select name="next_follow_up" id="next_follow_up" class="form-control">
                                                <option @if($lead->next_follow_up == 'yes') selected @endif value="yes"> @lang('app.yes')</option>
                                                <option @if($lead->next_follow_up == 'no') selected @endif value="no"> @lang('app.no')</option>
                                            </select>
                                        </div>
                                    </div>
                            </div>
                                <hr>
                                
                                <div class="row">
                                    @if(isset($fields))
                                        @foreach($fields as $field)
                                            <div class="col-md-4">
                                                <label>{{ ucfirst($field->label) }}</label>
                                                <div class="form-group">
                                                    @if( $field->type == 'text')
                                                        <input type="text" name="custom_fields_data[{{$field->name.'_'.$field->id}}]"  class="form-control" placeholder="{{$field->label}}" value="{{$lead->custom_fields_data['field_'.$field->id] ?? ''}}">
                                                    @elseif($field->type == 'password')
                                                        <input type="password" name="custom_fields_data[{{$field->name.'_'.$field->id}}]" class="form-control" placeholder="{{$field->label}}" value="{{$lead->custom_fields_data['field_'.$field->id] ?? ''}}">
                                                    @elseif($field->type == 'number')
                                                        <input type="number" name="custom_fields_data[{{$field->name.'_'.$field->id}}]" class="form-control" placeholder="{{$field->label}}" value="{{$lead->custom_fields_data['field_'.$field->id] ?? ''}}">
                        
                                                    @elseif($field->type == 'textarea')
                                                        <textarea name="custom_fields_data[{{$field->name.'_'.$field->id}}]" class="form-control" id="{{$field->name}}" cols="3">{{$lead->custom_fields_data['field_'.$field->id] ?? ''}}</textarea>
                        
                                                    @elseif($field->type == 'radio')
                                                        <div class="radio-list">
                                                            @foreach($field->values as $key=>$value)
                                                                <label class="radio-inline @if($key == 0) p-0 @endif">
                                                                    <div class="radio radio-info">
                                                                        <input type="radio" name="custom_fields_data[{{$field->name.'_'.$field->id}}]" id="optionsRadios{{$key.$field->id}}" value="{{$value}}" @if(isset($lead) && $lead->custom_fields_data['field_'.$field->id] == $value) checked @elseif($key==0) checked @endif>>
                                                                        <label for="optionsRadios{{$key.$field->id}}">{{$value}}</label>
                                                                    </div>
                                                                </label>
                                                            @endforeach
                                                        </div>
                                                    @elseif($field->type == 'select')
                                                        {!! Form::select('custom_fields_data['.$field->name.'_'.$field->id.']',
                                                            ['' => 'select'] + $field->values,
                                                                isset($lead)?$lead->custom_fields_data['field_'.$field->id]:'',['class' => 'form-control gender'])
                                                        !!}
                        
                                                    @elseif($field->type == 'checkbox')
                                                    <div class="mt-checkbox-inline custom-checkbox checkbox-{{$field->id}}">
                                                        <input type="hidden" name="custom_fields_data[{{$field->name.'_'.$field->id}}]" 
                                                        id="{{$field->name.'_'.$field->id}}" value=" ">
                                                        @foreach($field->values as $key => $value)
                                                            <label class="mt-checkbox mt-checkbox-outline">
                                                                <input name="{{$field->name.'_'.$field->id}}[]"
                                                                        type="checkbox" onchange="checkboxChange('checkbox-{{$field->id}}', '{{$field->name.'_'.$field->id}}')" value="{{$value}}"
                                                                        @if(isset($lead) && $lead->custom_fields_data['field_'.$field->id] == $value) checked @elseif($key==0) checked @endif > {{$value}}
                                                                <span></span>
                                                            </label>
                                                        @endforeach
                                                    </div>
                                                    @elseif($field->type == 'date')
                                                        <input type="text" class="form-control form-control-inline date-picker" size="16" name="custom_fields_data[{{$field->name.'_'.$field->id}}]"
                                                                value="{{ isset($lead->dob)?Carbon\Carbon::parse($lead->dob)->format('Y-m-d'):Carbon\Carbon::now()->format('m/d/Y')}}">
                                                    @endif
                                                    <div class="form-control-focus"> </div>
                                                    <span class="help-block"></span>
                        
                                                </div>
                                            </div>
                                        @endforeach
                                    @endif
                                </div>
                                
                                <hr>
                                <div class="row">
                                    <div class="col-md-12">
                                        <label>@lang('app.note')</label>
                                        <div class="form-group">
                                            <textarea name="note" id="note" class="form-control" rows="3">{{$lead->note}}</textarea>
                                        </div>
                                </div>
                                </div>
                            </div>
                            
                            <div class="form-actions">
                                <button type="submit" id="save-form" class="btn btn-success"> <i class="fa fa-check"></i> @lang('app.update')</button>
                                <a href="{{ route('member.leads.index') }}" class="btn btn-default">@lang('app.back')</a>
                            </div>
                        {!! Form::close() !!}
                    </div>
                </div>
            </div>
        </div>
    </div>    <!-- .row -->

@endsection

@push('footer-script')
<script src="{{ asset('plugins/bower_components/bootstrap-datepicker/bootstrap-datepicker.min.js') }}"></script>
<script>
    $(".date-picker").datepicker({
        todayHighlight: true,
        autoclose: true
    });
    
    $('#save-form').click(function () {
        $.easyAjax({
            url: '{{route('member.leads.update', [$lead->id])}}',
            container: '#updateLead',
            type: "POST",
            redirect: true,
            data: $('#updateLead').serialize()
        })
    });
</script>
@endpush