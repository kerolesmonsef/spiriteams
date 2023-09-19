@forelse($employeeTargetCurrent as $key=>$employeeTargetCurren)
    <tr>
        <td>{{ $key+1 }}</td>
        <td>{{ $employeeTargetCurren->date }}</td>
        <td>{{ $employeeTargetCurren->total }}</td>
    </tr>
@empty
    <tr>
        <td colspan="3">@lang('messages.noDocsFound')</td>
    </tr>
@endforelse
