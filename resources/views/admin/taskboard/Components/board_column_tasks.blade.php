@foreach($tasks as $task)
    <div class="panel panel-default lobipanel view-task" data-task-id="{{ $task->id }}"
         data-sortable="true">
        <div class="panel-body">
            <div class="p-10 p-b-0 font-12 font-semi-bold">{{ ucfirst($task->heading) }}
                <span class="m-l-5 pull-right text-info font-semi-bold">#{{ $task->id }}</span>

                @if ($task->is_private)
                    <label class="label pull-right"
                           style="background: #ea4c89">@lang('app.private')</label>
                @endif
            </div>
            @if (!is_null($task->project_id))
                <div class="p-10 p-t-5 text-muted"><small><i
                                class="icon-layers"></i> {{ ucfirst($task->project->project_name) }}
                    </small></div>
            @else
                <div class="p-10 p-t-5 text-muted" style="visibility: hidden"><small><i
                                class="icon-layers"></i></small></div>
            @endif

            @if (!is_null($task->label))
                <div class="p-10">
                    @foreach($task->label as $key => $label)
                        <label class="badge text-capitalize font-semi-bold"
                               style="background:{{ $label->label->label_color }}">{{ ucwords($label->label->label_name) }} </label>
                    @endforeach
                </div>
            @endif

            <div class="p-t-10 p-b-10 p-10">
                @foreach ($task->users as $item)
                    <img src="{{$item->image_url}}" data-toggle="tooltip"
                         data-original-title="{{ ucwords($item->name)}} " data-placement="right"
                         alt="user" class="img-circle" width="25" height="25">
                @endforeach
            </div>
            <div class="bg-grey p-10">

                @if($task->due_date->endOfDay()->isPast())
                    <span class="text-danger"><i class="icon-calender"></i> {{ $task->due_date->format($global->date_format) }}</span>
                @elseif($task->due_date->setTimezone($global->timezone)->isToday())
                    <span class="text-success"><i
                                class="icon-calender"></i> @lang('app.today')</span>
                @else
                    <span><i class="icon-calender"></i> {{ $task->due_date->format($global->date_format) }}</span>
                @endif

                <span class="pull-right" data-toggle="tooltip"
                      data-original-title="@lang('modules.tasks.comment')" data-placement="left">
                                        <i class="ti-comment"></i> {{ count($task->comments) }}
                                    </span>

                @if(count($task->subtasks) > 0)
                    <span class="pull-right m-r-5" data-toggle="tooltip"
                          data-original-title="@lang('modules.tasks.subTask')"
                          data-placement="left">
                                            <i class="ti-check-box"></i> {{ count($task->completedSubtasks) }} / {{ count($task->subtasks) }}
                                        </span>
                @endif

            </div>
        </div>
    </div>
@endforeach

<div class="panel panel-default lobipanel"  data-sortable="true"></div>
