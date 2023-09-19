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
    <h4>التارجت</h4>
    <div class="table-responsive">
        <table class="table">
            <thead>
            <tr>
                <th>الموظف</th>
                <th>@lang('app.call_w')</th>
                <th>@lang('app.call_m')</th>
                <th>@lang('app.visits_w')</th>
                <th>@lang('app.visits_m')</th>
                <th>@lang('app.money')</th>
            </tr>
            </thead>
            <tbody id="employeeTargetList">
           
            @forelse($employeeTarget as $key=>$employeeTarge)
                <tr>
                    <td>{{ $employeeTarge->user->name }}</td>
                    <td>{{ $employeeTarge->call_w }}</td>
                    <td>{{ $employeeTarge->call_m }}</td>
                    <td>{{ $employeeTarge->visits_w }}</td>
                    <td>{{ $employeeTarge->visits_m}}</td>
                    <td>{{ $employeeTarge->money }}</td>
                </tr>
            @empty
                <tr>
                    <td colspan="6" class="text-center">
                        <div class="empty-space" style="height: 200px;">
                            <div class="empty-space-inner">
                                <div class="icon" style="font-size:30px"><i
                                            class="fa fa-dashcube"></i>
                                </div>
                                <div class="title m-b-15">لا يوجد اي محتوي
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                @endforelse
            </tbody>
        </table>
    </div>  
    </div>
    </div>
    <div class="row">
        <div class="white-box">
        <h4>حالة الاتصال</h4>
         <div class="table-responsive">
         <table class="table">
                            <thead>
                            <tr>
                                <th>New Lead</th>
                                <th>Pending</th>
                                <th>Wrong Number</th>
                                <th>No Answer</th>
                                <th>Negotiation</th>
                                <th>Meeting</th>
                                <th>Deal</th>
                                <th>Lost</th>
                                <th>Proposal</th>
                                <th>Follow Up</th>
                                <th>Closed</th>
                                <th>Visits</th>
                            </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>{{$New_Lead}}</td>
                                    <td>{{$Pending}}</td>
                                    <td>{{$Wrong}}</td>
                                    <td>{{$No}}</td>
                                    <td>{{$Negotiation}}</td>
                                    <td>{{$Meeting}}</td>
                                    <td>{{$Deal}}</td>
                                    <td>{{$Lost}}</td>
                                    <td>{{$Proposal}}</td>
                                    <td>{{$Follow}}</td>
                                    <td>{{$Closed}}</td>
                                    <td>{{$Visits}}</td>
                                </tr>
                                @php 
                                $total = $New_Lead + $Pending + $Wrong + $No + $Negotiation + $Meeting + $Deal + $Lost + $Proposal + $Follow + $Closed;
                                @endphp
                                <th>اجمالي عدد  المكالمات الفعلية </th>
                                <th>{{$total}}</th>
                                <th>اجمالي عدد الزيارات الفعلية</th>
                                <th>{{$Visits}}</th>
                            </tbody>
                        </table>
                    </div>
    </div>
    </div>
    <div class="row">
    <div class="white-box">
        <h4>المبالغ المحققة</h4>
         <div class="table-responsive">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>الموظف</th>
                                <th>@lang('app.date')</th>
                                <th>@lang('app.total')</th>
                            </tr>
                            </thead>
                            <tbody id="employeeTargetList">
                            @forelse($employeeTargetCurrent as $key=>$employeeTargetCurren)
                                <tr>
                                    <td>{{ $employeeTargetCurren->user->name }}</td>
                                    <td>{{ $employeeTargetCurren->date }}</td>
                                    <td>{{ $employeeTargetCurren->total }}</td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="6" class="text-center">
                                        <div class="empty-space" style="height: 200px;">
                                            <div class="empty-space-inner">
                                                <div class="icon" style="font-size:30px"><i
                                                 class="fa fa-dashcube"></i>
                                                </div>
                                                <div class="title m-b-15">لا يوجد اي محتوي
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
    </div>
    </div>
    
    <div class="row">
      <canvas id="myChart" height="100px"></canvas>  
    </div>
    <!-- .row -->

@endsection
@push('footer-script')
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" ></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript">
  
      var labels ={{ $total }};
      var users ={{ $total }};
  
      const data = {
        labels: labels,
        datasets: [{
          label: 'My First dataset',
          backgroundColor: 'rgb(255, 99, 132)',
          borderColor: 'rgb(255, 99, 132)',
          data: users,
        }]
      };
  
      const config = {
        type: 'line',
        data: data,
        options: {}
      };
  
      const myChart = new Chart(
        document.getElementById('myChart'),
        config
      );
  
</script>
@endpush