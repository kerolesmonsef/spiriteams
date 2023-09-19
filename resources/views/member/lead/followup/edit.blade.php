<div class="panel panel-default">
    <div class="panel-heading "><i class="ti-pencil"></i> @lang('modules.followup.updateFollow')
        <div class="panel-action">
            <a href="javascript:;" class="close" id="hide-edit-follow-panel" data-dismiss="modal"><i class="ti-close"></i></a>
        </div>
    </div>
    <div class="panel-wrapper collapse in">
        <div class="panel-body">
            {!! Form::open(['id'=>'updateFollow','class'=>'ajax-form']) !!}
            {!! Form::hidden('lead_id', $follow->lead_id) !!}
            {!! Form::hidden('id', $follow->id) !!}

            <div class="form-body">
                <div class="row">
                    <!--/span-->
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label required">@lang('app.next_follow_up')</label>
                            <input type="text" autocomplete="off" name="next_follow_up_date" id="next_follow_up_date2" class="form-control" value="{{ $follow->next_follow_up_date->format('d/m/Y H:i a') }}">
                            <input type="hidden"  name="type" class="form-control datepicker" value="datetime">
                        </div>
                    </div>
                    
                     <!--/span-->
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label">@lang('app.description')</label>
                            <select id="followup_select_action_edit" class="form-control" name="followup_action">
                                <option value="first_call">First Call</option>
                                <option value="seconed_call">Seconed Call</option>
                                <option value="first_meeting">First Meeting</option>
                            </select>
                        </div>
                    </div>
                    <!--/span-->
                    
                    <!--/span-->
                    <div class="col-md-12">
                        <div class="form-group">
                            <label id="followup_discussion_label_edit" class="control-label">First Call Discussion</label>
                            <textarea id="followup_discussion_edit" name="first_call_discussion" class="form-control">{{$follow->first_call_discussion}}</textarea>
                        </div>
                    </div>
                    <!--/span-->
                    
                    <!--/span-->
                    <div class="col-md-12">
                        <div class="form-group">
                            <label id="followup_action_label_edit" class="control-label">First Call Action</label>
                            <textarea id="followup_action_edit" name="first_call_action" class="form-control">{{$follow->first_call_action}}</textarea>
                        </div>
                    </div>
                    <!--/span-->
                    
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="control-label required">@lang('modules.tasks.assignTo')</label>
                            <select class="select2 select2-multiple form-control" multiple="multiple"
                                    data-placeholder="@lang('modules.tasks.chooseAssignee')"
                                    name="user_id[]" id="user_id">
                                <option value=""></option>
                                @forelse($employees as $employee)
                                    <option value="{{ $employee->id }}" @if(in_array($employee->id,$follow->followup_mentions->pluck('user_id')->toArray())) selected @endif>{{ ucwords($employee->name) }}</option>
                                @empty
    
                                @endforelse
                            </select>
                        </div>
                    </div>
                    
                    <!--/span-->
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label">@lang('app.remark')</label>
                            <textarea id="remark" name="remark" class="form-control">{{ $follow->remark }}</textarea>
                        </div>
                    </div>
                </div>
                <!--/row-->

            </div>
            <div class="form-actions">
                <button type="button" id="update-follow" class="btn btn-success"><i class="fa fa-check"></i> @lang('app.save')</button>
            </div>
            {!! Form::close() !!}
        </div>
    </div>
</div>

<script>
    //    update task
    $('#update-follow').click(function () {
        $.easyAjax({
            url: '{{route('member.leads.follow-up-update')}}',
            container: '#updateFollow',
            type: "POST",
            data: $('#updateFollow').serialize(),
            success: function (data) {
                $('#follow-list-panel .list-group').html(data.html);
            }
        })
    });
    
    $('#followup_select_action_edit').change(function () {
        var labelVal = $(this).val();
        if(labelVal == 'first_call')
        {
            $('#followup_discussion_label_edit').html('First Call Discussion');
            $('#followup_action_label_edit').html('First Call Action');
            
            $('#followup_discussion_edit').attr('name','first_call_discussion');
            $('#followup_discussion_edit').html('{{$follow->first_call_discussion}}');
            
            $('#followup_action_edit').attr('name','first_call_action');
            $('#followup_action_edit').html('{{$follow->first_call_action}}');
        }
        else if(labelVal == 'seconed_call')
        {
            $('#followup_discussion_label_edit').html('Seconed Call Discussion');
            $('#followup_action_label_edit').html('Seconed Call Action');
            
            $('#followup_discussion_edit').attr('name','seconed_call_discussion');
            $('#followup_discussion_edit').html('{{$follow->seconed_call_discussion}}');
            
            $('#followup_action_edit').attr('name','seconed_call_action');
            $('#followup_action_edit').html('{{$follow->seconed_call_action}}');
        }
        else if(labelVal == 'first_meeting')
        {
            $('#followup_discussion_label_edit').html('First Meeting MOM');
            $('#followup_action_label_edit').html('First Meeting Action');
            
            $('#followup_discussion_edit').attr('name','first_meeting_mom');
            $('#followup_discussion_edit').html('{{$follow->first_meeting_mom}}');
            
            $('#followup_action_edit').attr('name','first_meeting_action');
            $('#followup_action_edit').html('{{$follow->first_meeting_action}}');
        }
    });

    jQuery('#next_follow_up_date2').datetimepicker({
        format: 'DD/MM/Y HH:mm',
    });
</script>
