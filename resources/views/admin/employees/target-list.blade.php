@forelse($employeeTarget as $key=>$employeeTarge)
    <tr>
        <td>{{ $key+1 }}</td>
        <td>{{ $employeeTarge->call_w }}</td>
        <td>{{ $employeeTarge->call_m }}</td>
        <td>{{ $employeeTarge->visits_w }}</td>
        <td>{{ $employeeTarge->visits_m}}</td>
        <td>{{ $employeeTarge->money }}</td>
        <td></td>
    </tr>
@empty
    <tr>
        <td colspan="3">@lang('messages.noDocsFound')</td>
    </tr>
@endforelse
