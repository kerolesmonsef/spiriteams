@extends('layouts.member-app')

@section('page-title')
    <div class="row bg-title">
        <!-- .page title -->
        <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
            <h4 class="page-title"><i class="{{ $pageIcon }}"></i> @lang($pageTitle)</h4>
        </div>
        <!-- /.page title -->
        <!-- .breadcrumb -->
        <div class="col-lg-9 col-sm-8 col-md-8 col-xs-12 text-right">
            <a href="javascript:;" id="toggle-filter" class="btn btn-outline btn-inverse btn-sm toggle-filter"><i
                        class="fa fa-sliders"></i> @lang('app.filterResults')</a>
            @if($user->can('add_tasks'))
                <a href="javascript:;" id="add-task" class="btn btn-sm btn-outline btn-info"><i
                            class="fa fa-plus"></i> @lang('app.task')</a>
                <a href="javascript:;" id="add-column" class="btn btn-success btn-sm btn-outline"><i
                            class="fa fa-plus"></i> @lang('modules.tasks.addBoardColumn')</a>
            @endif

            <ol class="breadcrumb">
                <li><a href="{{ route('member.dashboard') }}">@lang('app.menu.home')</a></li>
                <li class="active">@lang($pageTitle)</li>
            </ol>
        </div>
        <!-- /.breadcrumb -->
    </div>
@endsection

@push('head-script')
    <link rel="stylesheet" href="{{ asset('plugins/bower_components/lobipanel/dist/css/lobipanel.min.css') }}">
    <link rel="stylesheet"
          href="{{ asset('plugins/bower_components/jquery-asColorPicker-master/css/asColorPicker.css') }}">
    <link rel="stylesheet"
          href="{{ asset('plugins/bower_components/bootstrap-datepicker/bootstrap-datepicker.min.css') }}">
    <link rel="stylesheet" href="{{ asset('plugins/bower_components/bootstrap-select/bootstrap-select.min.css') }}">
    <link rel="stylesheet" href="{{ asset('plugins/bower_components/custom-select/custom-select.css') }}">

@endpush

@section('content')

    <div class="row">
        <div class="white-box">

            <div class="row" style="display: none;" id="ticket-filters">

                <form action="" id="filter-form">
                    <div class="col-md-3">
                        <h5>@lang('app.selectDateRange')</h5>
                        <div class="input-daterange input-group m-t-5" id="date-range">
                            <input type="text" class="form-control" id="start-date" placeholder="@lang('app.startDate')"
                                   value="{{ $startDate }}"/>
                            <span class="input-group-addon bg-info b-0 text-white">@lang('app.to')</span>
                            <input type="text" class="form-control" id="end-date" placeholder="@lang('app.endDate')"
                                   value="{{ $endDate }}"/>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <h5>@lang('app.selectProject')</h5>
                        <div class="form-group">
                            <select class="select2 form-control" data-placeholder="@lang('app.selectProject')"
                                    id="project_id">
                                <option value="all">@lang('app.all')</option>
                                @foreach($projects as $project)
                                    <option
                                            value="{{ $project->id }}">{{ ucwords($project->project_name) }}</option>
                                @endforeach
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <h5>@lang('app.select') @lang('app.client')</h5>

                        <div class="form-group">
                            <select class="select2 form-control" data-placeholder="@lang('app.client')" id="clientID">
                                <option value="all">@lang('app.all')</option>
                                @foreach($clients as $client)
                                    <option
                                            value="{{ $client->id }}">{{ ucwords($client->name) }}</option>
                                @endforeach
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <h5>@lang('app.select') @lang('modules.tasks.assignTo')</h5>

                        <div class="form-group">
                            <select class="select2 form-control" data-placeholder="@lang('modules.tasks.assignTo')"
                                    id="assignedTo">
                                <option value="all">@lang('app.all')</option>
                                @foreach($employees as $employee)
                                    <option
                                            value="{{ $employee->id }}">{{ ucwords($employee->name) }}</option>
                                @endforeach
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <h5>@lang('app.select') @lang('modules.tasks.assignBy')</h5>

                        <div class="form-group">
                            <select class="select2 form-control" data-placeholder="@lang('modules.tasks.assignBy')"
                                    id="assignedBY">
                                <option value="all">@lang('app.all')</option>
                                @foreach($employees as $employee)
                                    <option
                                            value="{{ $employee->id }}">{{ ucwords($employee->name) }}</option>
                                @endforeach
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group m-t-10">
                            <label class="control-label col-xs-12">&nbsp;</label>
                            <button type="button" id="apply-filters" class="btn btn-success btn-sm"><i
                                        class="fa fa-check"></i> @lang('app.apply')</button>
                            <button type="button" id="reset-filters" class="btn btn-inverse btn-sm"><i
                                        class="fa fa-refresh"></i> @lang('app.reset')</button>
                        </div>
                    </div>
                </form>
            </div>
            {!! Form::open(['id'=>'addColumn','class'=>'ajax-form','method'=>'POST']) !!}
            <div class="row" id="add-column-form" style="display: none;">
                <div class="col-md-12">
                    <hr>
                    <div class="form-group">
                        <label class="control-label required">@lang("modules.tasks.columnName")</label>
                        <input type="text" name="column_name" class="form-control">
                    </div>
                </div>
                <!--/span-->

                <div class="col-md-4">
                    <div class="form-group">
                        <label class="required">@lang("modules.tasks.labelColor")</label><br>
                        <input type="text" class="colorpicker form-control" name="label_color" value="#ff0000"/>
                    </div>
                </div>

                <div class="col-md-12">
                    <div class="form-group">
                        <button class="btn btn-success" id="save-form" type="submit"><i
                                    class="fa fa-check"></i> @lang('app.save')</button>
                    </div>
                </div>
                <!--/span-->
            </div>
            {!! Form::close() !!}


            {!! Form::open(['id'=>'updateColumn','class'=>'ajax-form','method'=>'POST']) !!}
            <div class="row" id="edit-column-form" style="display: none;">


            </div>
            <!--/row-->
            {!! Form::close() !!}
        </div>

    </div>

    <div class="container-scroll white-box">
        <div class="row">
            <a href="javascript:;" id="toggle_fullscreen" class="btn btn-inverse btn-outline btn-sm pull-right"><i
                        class="icon-size-fullscreen"></i></a>
        </div>
        <div class="row container-row">
            @foreach($boardColumns as $key => $column)
                <div class="panel col-xs-3 board-column p-0 panel-column-id-{{ $column->id }}"
                     data-column-id="{{ $column->id }}" data-next-offset="10">
                    <div class="panel-heading p-t-5 p-b-5">
                        <div class="panel-title">
                            <h6 style="color: {{ $column->label_color }}">{{ ucwords($column->column_name) }}
                                <div style="position: relative;" class="dropdown pull-right">
                                    <a href="javascript:;" data-toggle="dropdown" class="dropdown-toggle "><i
                                                class="ti-settings font-normal"></i></a>
                                    <ul role="menu" class="dropdown-menu">
                                        <li><a href="javascript:;" data-column-id="{{ $column->id }}"
                                               class="add-task">@lang('modules.tasks.newTask')</a></li>
                                    </ul>

                                </div>
                            </h6>
                        </div>
                    </div>
                    <div class="panel-body" id="taskBox_{{ $column->id }}"
                         data-column-id="{{ $column->id }}"
                         style="height: 70vh; overflow-y: auto">
                        <div class="row">
                            <div class="col-xs-12" style="height: 400px !important;"
                                 id="taskcolumn_tasks_{{ $column->id }}">
                            </div>
                        </div>

                    </div>
                </div>
            @endforeach
        </div>
        <!-- .row -->
    </div>

    {{--Ajax Modal--}}
    <div class="modal fade bs-modal-md in" id="eventDetailModal" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-lg" id="modal-data-application">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <span class="caption-subject font-red-sunglo bold uppercase" id="modelHeading"></span>
                </div>
                <div class="modal-body">
                    Loading...
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn blue">Save changes</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    {{--Ajax Modal Ends--}}

    {{--Ajax Modal--}}
    <div class="modal fade bs-modal-md in" id="subTaskModal" role="dialog" aria-labelledby="myModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-md" id="modal-data-application">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <span class="caption-subject font-red-sunglo bold uppercase"
                          id="subTaskModelHeading">Sub Task e</span>
                </div>
                <div class="modal-body">
                    Loading...
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn blue">Save changes</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->.
    </div>
    {{--Ajax Modal Ends--}}


@endsection

@push('footer-script')
    <script src="{{ asset('plugins/bower_components/lobipanel/dist/js/lobipanel.min.js') }}"></script>
    <script src="{{ asset('plugins/bower_components/jquery-asColorPicker-master/libs/jquery-asColor.js') }}"></script>
    <script src="{{ asset('plugins/bower_components/jquery-asColorPicker-master/libs/jquery-asGradient.js') }}"></script>
    <script src="{{ asset('plugins/bower_components/jquery-asColorPicker-master/dist/jquery-asColorPicker.min.js') }}"></script>
    <script src="{{ asset('plugins/bower_components/bootstrap-datepicker/bootstrap-datepicker.min.js') }}"></script>
    <script src="{{ asset('plugins/bower_components/bootstrap-daterangepicker/daterangepicker.js') }}"></script>
    <script src="{{ asset('js/jquery.slimscroll.js') }}"></script>

    <script src="{{ asset('plugins/bower_components/custom-select/custom-select.min.js') }}"></script>
    <script src="{{ asset('plugins/bower_components/bootstrap-select/bootstrap-select.min.js') }}"></script>

    <script>
        $('#add-column').click(function () {
            $('#add-column-form').toggle();
        });

        $(".select2").select2({
            formatNoMatches: function () {
                return "{{ __('messages.noRecordFound') }}";
            }
        });

        loadData();
        jQuery('#date-range').datepicker({
            toggleActive: true,
            format: '{{ $global->date_picker_format }}',
            language: '{{ $global->locale }}',
            autoclose: true
        });
        // Colorpicker

        $(".colorpicker").asColorPicker();


        $('#save-form').click(function () {
            $.easyAjax({
                url: '{{route('member.taskboard.store')}}',
                container: '#addColumn',
                data: $('#addColumn').serialize(),
                type: "POST"
            })
        });

        $('#edit-column-form').on('click', '#update-form', function () {
            var id = $(this).data('column-id');
            var url = '{{route('member.taskboard.update', ':id')}}';
            url = url.replace(':id', id);

            $.easyAjax({
                url: url,
                container: '#updateColumn',
                data: $('#updateColumn').serialize(),
                type: "PUT"
            })
        });
        $('#apply-filters').click(function () {
            loadData();
        });
        $('#reset-filters').click(function () {
            $('#start-date').val('{{ $startDate }}');
            $('#end-date').val('{{ $endDate }}');
            $('.select2').val('all');
            $('.select2').trigger('change');

            loadData();
        });

        $('.toggle-filter').click(function () {
            $('#ticket-filters').slideToggle();
        });

        $('#add-task').click(function () {
            var url = '{{ route('member.projects.ajaxCreate')}}';
            $('#modelHeading').html('Add Task');
            $.ajaxModal('#eventDetailModal', url);
        });

        function loadData({taskboard_column_id = null, removePrevious = true, offset = null} = {}) {
            var startDate = $('#start-date').val();

            if (startDate == '') {
                startDate = null;
            }

            var endDate = $('#end-date').val();

            if (endDate == '') {
                endDate = null;
            }
            var projectID = $('#project_id').val();
            var clientID = $('#clientID').val();
            var assignedBY = $('#assignedBY').val();
            var assignedTo = $('#assignedTo').val();

            let columnIds = @json($boardColumnsIds);
            if (taskboard_column_id) {
                columnIds = [taskboard_column_id];
            }
            // var url = '{{route('member.taskboard.index')}}?startDate=' + encodeURIComponent(startDate) + '&endDate=' + encodeURIComponent(endDate) + '&clientID=' + clientID + '&assignedBY=' + assignedBY + '&assignedTo=' + assignedTo + '&projectID=' + projectID;
            for (let columnId of columnIds) {
                var columnTasks = `{{ route('member.taskboard.columnTasks') }}?startDate=${encodeURIComponent(startDate)}&endDate=${encodeURIComponent(endDate)}` + '&clientID=' + clientID + '&assignedBY=' + assignedBY + '&assignedTo=' + assignedTo + '&projectID=' + projectID;
                $.easyAjax({
                    url: columnTasks,
                    container: '.container-row',
                    data: {
                        'taskboard_column_id': columnId,
                        offset: offset,
                    },
                    type: "GET",
                    success: function (response) {
                        const columnJquery = $(`#taskcolumn_tasks_${response.taskboard_column_id}`);
                        if (removePrevious) {
                            columnJquery.children().remove();
                        }
                        columnJquery.append(response.tasks);

                        $(`.panel-column-id-${response.taskboard_column_id}`).attr("data-next-offset", response.next_offset);

                        syncLoadMoreButton(response.taskboard_column_id, response.thereIsMore);
                        loadKanaban();
                    }
                });
            }
        }

        function syncLoadMoreButton(columnId, thereIsMore) {
            $(`#taskcolumn_tasks_${columnId}`).find('.load_more_dev').remove();
            if (thereIsMore)
                $(`#taskcolumn_tasks_${columnId}`).append(`<div class="load_more_dev"><button data-column-id="${columnId}" class="btn btn-success btn-sm load_more_button">Load More</button></div>`)
        }

        //    update task
        function storeTask() {
            $('#store-task').attr('disabled','disabled');
            // console.log( $('#storeTask').serialize());
            var data = new FormData();

            //Form data
            var form_data = $('#storeTask').serializeArray();
            $.each(form_data, function (key, input) {
                data.append(input.name, input.value);
            });

            // console.log(form_data,data);

            //File data
            var file_data = $('#upload_file')[0].files;
            for (var i = 0; i < file_data.length; i++) {
                data.append("upload_file[]", file_data[i]);
            }


            $.ajax({
                url: '{{route('member.all-tasks.store')}}',
                container: '#storeTask',
                type: "POST",
                processData: false,
                contentType: false,
                enctype: 'multipart/form-data',
                cache: false,
                data: data,
                success: function (response) {
                    $('#eventDetailModal').modal('hide');
                    loadData()
                    $('#store-task').removeAttr('disabled');

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $('#store-task').removeAttr('disabled');
                    var response = JSON.parse(jqXHR.responseText);
                    if (typeof response == "object") {
                        $.toast({
                            heading: "",
                            text: response.message,
                            position: 'top-right',
                            loaderBg: '#ff6849',
                            icon: "error",
                            hideAfter: 3500

                        });
                        // handleFail(response);
                    } else {
                        var msg = "A server side error occurred. Please try again after sometime.";

                        if (textStatus == "timeout") {
                            msg = "Connection timed out! Please check your internet connection";
                        }
                        console.log(msg, response);
                        $.toast({
                            heading: "",
                            text: msg,
                            position: 'top-right',
                            loaderBg: '#ff6849',
                            icon: iconClasses[type],
                            hideAfter: 3500

                        });
                    }

                }
            })
        }
    </script>

    <script>
        $('#toggle_fullscreen').on('click', function () {
            // if already full screen; exit
            // else go fullscreen
            if (
                document.fullscreenElement ||
                document.webkitFullscreenElement ||
                document.mozFullScreenElement ||
                document.msFullscreenElement
            ) {
                if (document.exitFullscreen) {
                    document.exitFullscreen();
                } else if (document.mozCancelFullScreen) {
                    document.mozCancelFullScreen();
                } else if (document.webkitExitFullscreen) {
                    document.webkitExitFullscreen();
                } else if (document.msExitFullscreen) {
                    document.msExitFullscreen();
                }
            } else {
                element = $('.container-scroll').get(0);
                if (element.requestFullscreen) {
                    element.requestFullscreen();
                } else if (element.mozRequestFullScreen) {
                    element.mozRequestFullScreen();
                } else if (element.webkitRequestFullscreen) {
                    element.webkitRequestFullscreen(Element.ALLOW_KEYBOARD_INPUT);
                } else if (element.msRequestFullscreen) {
                    element.msRequestFullscreen();
                }
            }
        });
    </script>

    {{-- Kanaban--}}
    <script>

        let draggingTaskId = 0;
        let draggedTaskId = 0;
        let isDragging = 0;

        $(document).on('click', '.add-task', function () {
            var id = $(this).data('column-id');
            var url = '{{ route('member.all-tasks.ajaxCreate', ':id')}}';
            url = url.replace(':id', id);

            $('#modelHeading').html('...');
            $.ajaxModal('#eventDetailModal', url);
        });

        $(document).on('click', '.delete-column', function () {
            var id = $(this).data('column-id');
            var url = '{{ route('member.taskboard.destroy', ':id')}}';
            url = url.replace(':id', id);

            swal({
                title: "@lang('messages.sweetAlertTitle')",
                text: "@lang('messages.deleteColumn')",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "@lang('messages.confirmDelete')",
                cancelButtonText: "@lang('messages.confirmNoArchive')",
                closeOnConfirm: true,
                closeOnCancel: true
            }, function (isConfirm) {
                if (isConfirm) {
                    $.easyAjax({
                        url: url,
                        type: 'POST',
                        data: {'_token': '{{ csrf_token() }}', '_method': 'DELETE'},
                        success: function (response) {
                            if (response.status == 'success') {
                                window.location.reload();
                            }
                        }
                    });

                }
            });

        });

        $(document).on('click', '.view-task', function () {
            var id = $(this).data('task-id');
            draggingTaskId = id;

            if (isDragging == 0) {

                $(".right-sidebar").slideDown(50).addClass("shw-rside");

                var url = "{{ route('member.all-tasks.show',':id') }}";
                url = url.replace(':id', id);

                $.easyAjax({
                    type: 'GET',
                    url: url,
                    success: function (response) {
                        if (response.status == "success") {
                            $('#right-sidebar-content').html(response.view);
                        }
                    }
                });
            }
        });

        $(document).on('.edit-column', function () {
            var id = $(this).data('column-id');
            var url = '{{ route("member.taskboard.edit", ':id') }}';
            url = url.replace(':id', id);

            $.easyAjax({
                url: url,
                type: "GET",
                success: function (response) {
                    $('#edit-column-form').html(response.view);
                    $(".colorpicker").asColorPicker();
                    $('#edit-column-form').show();
                }
            })
        });

        $(document).on('sortactivate', '.lobipanel-parent-sortable', function () {
            // console.log("activate event handle");
            $('.board-column > .panel-body').css('overflow-y', 'unset');
            isDragging = 1;
        });
        $(document).on('sortstop', '.lobipanel-parent-sortable', function (e) {
            // console.log("stop event handle");
            $('.board-column > .panel-body').css('overflow-y', 'auto');
            isDragging = 0;
        });

        function loadKanaban() {
            $(document).ready(function () {
                $('.lobipanel').unbind('dragged.lobiPanel');
                $('.lobipanel').on('dragged.lobiPanel', function () {
                    var $parent = $(this).parent(),
                        $children = $parent.children();

                    var boardColumnIds = [];
                    var taskIds = [];
                    var prioritys = [];

                    $children.each(function (ind, el) {
//                console.log(el, $(el).index());
                        boardColumnIds.push($(el).closest('.board-column').data('column-id'));
                        taskIds.push($(el).data('task-id'));
                        prioritys.push($(el).index());
                    });

                    // update values for all tasks

                    $.easyAjax({
                        url: '{{ route("member.taskboard.updateIndex") }}',
                        type: 'POST',
                        data: {
                            boardColumnIds: boardColumnIds,
                            taskIds: taskIds,
                            prioritys: prioritys,
                            '_token': '{{ csrf_token() }}',
                            draggingTaskId: draggingTaskId,
                            draggedTaskId: draggedTaskId
                        },
                        success: function (response) {
                            draggedTaskId = draggingTaskId;
                            draggingTaskId = 0;
                        }
                    });

                    $("body").tooltip({
                        selector: '[data-toggle="tooltip"]'
                    });

                    $('.board-column').each(function () {
                        let lobipanelItems = $(this).find('.view-task').length;
                        // console.log(lobipanelItems);
                        if (lobipanelItems == 1) {
                            $(this).find('.lobipanel:first').addClass('m-b-0');
                        }
                    })

                }).lobiPanel({
                    sortable: true,
                    reload: false,
                    editTitle: false,
                    close: false,
                    minimize: false,
                    unpin: false,
                    expand: false
                });
            });
        }

        $(document).on('click', '.load_more_button', function () {

            const task_column_id = $(this).attr("data-column-id");

            const offset = $(`.panel-column-id-${task_column_id}`).attr("data-next-offset");

            loadData({taskboard_column_id: task_column_id, removePrevious: false, offset});
        });

    </script>

@endpush


@section('pusher-event')
    <script>
        // Subscribe to the channel we specified in our Laravel Event
        var channel = pusher.subscribe('task-updated-channel');
        channel.bind('task-updated', function (data) {
            let authId = "{{ $user->id }}";
            if (data.user_id != authId) {
                loadData();
            }

        });
    </script>
@endsection