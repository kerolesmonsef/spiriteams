<?php

namespace App\Http\Controllers\Member;

use App\Attendance;
use App\AttendanceSetting;
use App\Holiday;
use App\Notice;
use App\DashboardWidget;
use App\Project;
use App\ProjectActivity;
use App\ProjectTimeLog;
use App\Task;
use App\TaskboardColumn;
use App\UserActivity;
use Carbon\Carbon;
use App\User;
use App\Payment;
use App\Lead;
use App\LeadFollowUp;
use App\LeadSource;
use App\LeadStatus;
use Illuminate\Support\Facades\DB;

class MemberDashboardController extends MemberBaseController
{
    public function __construct()
    {
        parent::__construct();

        $this->pageTitle = 'app.menu.dashboard';
        $this->pageIcon = 'icon-speedometer';

        // Getting Attendance setting data
        $this->attendanceSettings = AttendanceSetting::first();

        //Getting Maximum Check-ins in a day
        $this->maxAttendanceInDay = $this->attendanceSettings->clockin_in_day;
    }

    public function index()
    {
        $this->languageSettings = language_setting();
        $this->timer = ProjectTimeLog::memberActiveTimer($this->user->id);
        $completedTaskColumn = TaskboardColumn::completeColumn();

        $this->totalProjects = Project::select('projects.id')
            ->join('project_members', 'project_members.project_id', '=', 'projects.id');

        if (!$this->user->can('view_projects')) {
            $this->totalProjects = $this->totalProjects->where('project_members.user_id', '=', $this->user->id);
        }

        $this->totalProjects =  $this->totalProjects->groupBy('projects.id');
        $this->totalProjects = count($this->totalProjects->get());
        $this->counts = DB::table('users')
            ->select(
                DB::raw('(select IFNULL(sum(project_time_logs.total_minutes),0) from `project_time_logs` where user_id = ' . $this->user->id . ') as totalHoursLogged '),
                DB::raw('(select count(tasks.id) from `tasks` inner join task_users on task_users.task_id=tasks.id where tasks.board_column_id=' . $completedTaskColumn->id . ' and task_users.user_id = ' . $this->user->id . ') as totalCompletedTasks'),
                DB::raw('(select count(tasks.id) from `tasks` inner join task_users on task_users.task_id=tasks.id where tasks.board_column_id!=' . $completedTaskColumn->id . ' and task_users.user_id = ' . $this->user->id . ') as totalPendingTasks')
            )
            ->first();

        $timeLog = intdiv($this->counts->totalHoursLogged, 60) . ' hrs ';

        if (($this->counts->totalHoursLogged % 60) > 0) {
            $timeLog .= ($this->counts->totalHoursLogged % 60) . ' mins';
        }

        $this->counts->totalHoursLogged = $timeLog;

        $this->projectActivities = ProjectActivity::join('projects', 'projects.id', '=', 'project_activity.project_id')
            ->join('project_members', 'project_members.project_id', '=', 'projects.id');

        if (!$this->user->can('view_projects')) {
            $this->projectActivities = $this->projectActivities->where('project_members.user_id', '=', $this->user->id);
        }

        $this->projectActivities = $this->projectActivities->whereNull('projects.deleted_at')
            ->select('projects.project_name', 'project_activity.created_at', 'project_activity.activity', 'project_activity.project_id')
            ->limit(15)->orderBy('project_activity.id', 'desc')->groupBy('project_activity.id')->get();

        if ($this->user->can('view_notice')) {
            $this->notices = Notice::latest()->get();
        }

        $this->userActivities = UserActivity::with('user')->limit(15)->orderBy('id', 'desc');

        if (!$this->user->can('view_employees')) {
            $this->userActivities = $this->userActivities->where('user_id', $this->user->id);
        }

        $this->userActivities = $this->userActivities->get();

        $this->pendingTasks = Task::with('project')
            ->join('task_users', 'task_users.task_id', '=', 'tasks.id')
            ->where('tasks.board_column_id', '<>', $completedTaskColumn->id)
            ->where(DB::raw('DATE(due_date)'), '<=', Carbon::today()->format('Y-m-d'))
            ->where('task_users.user_id', $this->user->id)
            ->select('tasks.*')
            ->groupBy('tasks.id')
            ->limit(15)
            ->get();


        // Getting Current Clock-in if exist
        $this->currenntClockIn = Attendance::where(DB::raw('DATE(clock_in_time)'), Carbon::today()->format('Y-m-d'))
            ->where('user_id', $this->user->id)->whereNull('clock_out_time')->first();

        // Getting Today's Total Check-ins
        $this->todayTotalClockin = Attendance::where(DB::raw('DATE(clock_in_time)'), Carbon::today()->format('Y-m-d'))
            ->where('user_id', $this->user->id)->where(DB::raw('DATE(clock_out_time)'), Carbon::today()->format('Y-m-d'))->count();

        $currentDate = Carbon::now()->format('Y-m-d');

        // Check Holiday by date
        $this->checkTodayHoliday = Holiday::where('date', $currentDate)->first();

        //check office time passed
        $officeEndTime = Carbon::createFromFormat('H:i:s', $this->attendanceSettings->office_end_time, $this->global->timezone)->timestamp;
        $currentTime = Carbon::now()->timezone($this->global->timezone)->timestamp;
        if ($officeEndTime < $currentTime) {
            // $this->noClockIn = true;
        }

        if ($this->user->can('view_timelogs') && in_array('timelogs', $this->user->modules)) {

            $this->activeTimerCount = ProjectTimeLog::with('user', 'project', 'task')
                ->whereNull('end_time')
                ->join('users', 'users.id', '=', 'project_time_logs.user_id');

            $this->activeTimerCount = $this->activeTimerCount
                ->select('project_time_logs.*', 'users.name')
                ->count();
        }

        $this->languageSettings = language_setting();

        return view('member.dashboard.index', $this->data);
    }
    
     public function clientDashboard(Request $request)
    {
        $this->pageTitle = 'app.clientDashboard';

        $this->fromDate = Carbon::now()->timezone($this->global->timezone)->subDays(30)->toDateString();
        $this->toDate = Carbon::now()->timezone($this->global->timezone)->toDateString();
        $this->widgets = DashboardWidget::where('dashboard_type', 'member-client-dashboard')->get();
        $this->activeWidgets = DashboardWidget::where('dashboard_type', 'member-client-dashboard')->where('status', 1)->get()->pluck('widget_name')->toArray();
        if (request()->ajax()) {
            if (!is_null($request->startDate) && $request->startDate != "null" && !is_null($request->endDate) && $request->endDate != "null") {
                $this->fromDate = Carbon::createFromFormat($this->global->date_format, $request->startDate)->toDateString();
                $this->toDate = Carbon::createFromFormat($this->global->date_format, $request->endDate)->toDateString();
            }

            $this->totalClient = User::withoutGlobalScope('active')
                ->join('role_user', 'role_user.user_id', '=', 'users.id')
                ->join('roles', 'roles.id', '=', 'role_user.role_id')
                ->leftJoin('client_details', 'users.id', '=', 'client_details.user_id')
                ->where('roles.name', 'client')
                ->whereBetween(DB::raw('DATE(client_details.`created_at`)'), [$this->fromDate, $this->toDate])
                ->select('users.id')
                ->get()->count();
            $this->totalLead = Lead::whereBetween(DB::raw('DATE(`created_at`)'), [$this->fromDate, $this->toDate])
                ->get()
                ->count();

            $this->totalLeadConversions = Lead::whereBetween(DB::raw('DATE(`updated_at`)'), [$this->fromDate, $this->toDate])
                ->whereNotNull('client_id')
                ->get()
                ->count();

            $this->totalContractsGenerated = Contract::whereBetween(DB::raw('DATE(`created_at`)'), [$this->fromDate, $this->toDate])
                ->get()
                ->count();

            $this->totalContractsSigned = ContractSign::whereBetween(DB::raw('DATE(`created_at`)'), [$this->fromDate, $this->toDate])
                ->get()
                ->count();

            $this->recentLoginActivities = User::withoutGlobalScope('active')
                ->join('role_user', 'role_user.user_id', '=', 'users.id')
                ->join('roles', 'roles.id', '=', 'role_user.role_id')
                ->leftJoin('client_details', 'users.id', '=', 'client_details.user_id')
                ->where('roles.name', 'client')
                ->whereNotNull('last_login')
                ->whereBetween(DB::raw('DATE(client_details.`created_at`)'), [$this->fromDate, $this->toDate])
                ->select('users.id', 'users.name', 'users.last_login', 'client_details.company_name')
                ->limit(10)
                ->orderBy('users.last_login', 'desc')
                ->get();
            // dd($this->recentLoginActivities);
            $this->latestClient = User::withoutGlobalScope('active')
                ->join('role_user', 'role_user.user_id', '=', 'users.id')
                ->join('roles', 'roles.id', '=', 'role_user.role_id')
                ->leftJoin('client_details', 'users.id', '=', 'client_details.user_id')
                ->where('roles.name', 'client')
                ->whereBetween(DB::raw('DATE(client_details.`created_at`)'), [$this->fromDate, $this->toDate])
                ->select('users.id', 'users.name', 'users.created_at', 'client_details.company_name')
                ->limit(10)
                ->orderBy('users.created_at', 'Asc')
                ->get();


            // client wise earning chart

            $projects = Payment::join('currencies', 'currencies.id', '=', 'payments.currency_id')
                ->join('projects', 'projects.id', '=', 'payments.project_id')
                ->join('users', 'users.id', '=', 'projects.client_id')
                ->whereBetween(DB::raw('DATE(payments.`paid_on`)'), [$this->fromDate, $this->toDate])
                ->where('payments.status', 'complete')
                ->groupBy('date')
                ->orderBy('payments.paid_on', 'ASC')
                ->select(
                    DB::raw('DATE_FORMAT(payments.paid_on,"%Y-%m-%d") as date'),
                    DB::raw('sum(payments.amount) as total'),
                    'currencies.currency_code',
                    'currencies.is_cryptocurrency',
                    'currencies.usd_price',
                    'currencies.exchange_rate',
                    'users.name'
                );

            $invoices = Payment::join('currencies', 'currencies.id', '=', 'payments.currency_id')
                ->join('invoices', 'invoices.id', '=', 'payments.invoice_id')
                ->join('users', 'users.id', '=', 'invoices.client_id')
                ->whereBetween(DB::raw('DATE(payments.`paid_on`)'), [$this->fromDate, $this->toDate])
                ->where('payments.status', 'complete')
                ->groupBy('date')
                ->orderBy('payments.paid_on', 'ASC')
                ->select(
                    DB::raw('DATE_FORMAT(payments.paid_on,"%Y-%m-%d") as date'),
                    DB::raw('sum(payments.amount) as total'),
                    'currencies.currency_code',
                    'currencies.is_cryptocurrency',
                    'currencies.usd_price',
                    'currencies.exchange_rate',
                    'users.name'
                )
                ->union($projects)
                ->get();

            $chartData = array();
            $chartDataClients = array();
            foreach ($invoices as $chart) {
                if (!array_key_exists($chart->name, $chartDataClients)) {
                    $chartDataClients[$chart->name] = 0;
                }
                if ($chart->currency_code != $this->global->currency->currency_code) {
                    if ($chart->is_cryptocurrency == 'yes') {
                        if ($chart->exchange_rate == 0) {
                            if ($this->updateExchangeRates()) {
                                $usdTotal = ($chart->total * $chart->usd_price);
                                $chartDataClients[$chart->name] = $chartDataClients[$chart->name] + floor($usdTotal / $chart->exchange_rate);
                            }
                        } else {
                            $usdTotal = ($chart->total * $chart->usd_price);
                            $chartDataClients[$chart->name] = $chartDataClients[$chart->name] + floor($usdTotal / $chart->exchange_rate);
                        }
                    } else {
                        if ($chart->exchange_rate == 0) {
                            if ($this->updateExchangeRates()) {
                                $chartDataClients[$chart->name] = $chartDataClients[$chart->name] + floor($chart->total / $chart->exchange_rate);
                            }
                        } else {
                            $chartDataClients[$chart->name] = $chartDataClients[$chart->name] + floor($chart->total / $chart->exchange_rate);
                        }
                    }
                } else {
                    $chartDataClients[$chart->name] = $chartDataClients[$chart->name] + round($chart->total, 2);
                }
            }
            foreach ($chartDataClients as $key => $chartDataClient) {
                $chartData[] = ['client' => $key, 'total' => $chartDataClient];
            }

            $this->chartData = json_encode($chartData);

            // client wise timelogs

            $projectTimelogs = ProjectTimeLog::join('projects', 'projects.id', 'project_time_logs.project_id')
                ->join('users', 'users.id', 'projects.client_id')
                ->whereBetween(DB::raw('DATE(project_time_logs.`created_at`)'), [$this->fromDate, $this->toDate])
                ->where('project_time_logs.approved', 1)
                ->select('project_time_logs.*', 'users.name');

            $allTimelogs = ProjectTimeLog::join('tasks', 'tasks.id', 'project_time_logs.task_id')
                ->join('projects', 'projects.id', 'tasks.project_id')
                ->join('users', 'users.id', 'projects.client_id')
                ->whereBetween(DB::raw('DATE(project_time_logs.`created_at`)'), [$this->fromDate, $this->toDate])
                ->where('project_time_logs.approved', 1)
                ->select('project_time_logs.*', 'users.name')
                ->union($projectTimelogs)
                ->get();

            $clientWiseTimelogs = array();
            $clientWiseTimelogChartData = array();

            foreach ($allTimelogs as $timelog) {
                if (!array_key_exists($timelog->name, $clientWiseTimelogs)) {
                    $clientWiseTimelogs[$timelog->name] = 0;
                }
                $clientWiseTimelogs[$timelog->name] = $clientWiseTimelogs[$timelog->name] + $timelog->total_minutes;
            }
            foreach ($clientWiseTimelogs as $key => $clientWiseTimelog) {
                $totalTime = intdiv($clientWiseTimelog, 60);
                $clientWiseTimelogChartData[] = ['client' => $key, 'totalHours' => $totalTime];
            }
            $this->clientWiseTimelogChartData = json_encode($clientWiseTimelogChartData);

            // total lead vs status
            $leadVsStatus = array();
            $leadStatus = LeadStatus::get();
            foreach ($leadStatus as $status) {
                $leadCount = Lead::where('status_id', $status->id)
                    ->whereBetween(DB::raw('DATE(`created_at`)'), [$this->fromDate, $this->toDate])
                    ->get()
                    ->count();
                if ($leadCount > 0) {
                    $leadVsStatus[] = ['total' => $leadCount, 'label' => $status->type, 'color' => $status->label_color];
                }
            }
            $this->leadVsStatus = json_encode($leadVsStatus);
            // dd($this->leadVsStatus);
            // total lead vs source
            $leadVsSource = array();
            $leadSource = LeadSource::get();
            foreach ($leadSource as $source) {
                $leadCount = Lead::where('source_id', $source->id)
                    ->whereBetween(DB::raw('DATE(`created_at`)'), [$this->fromDate, $this->toDate])
                    ->get()
                    ->count();
                // dd($source->id);
                if ($leadCount > 0) {
                    $leadVsSource[] = ['total' => $leadCount, 'label' => $source->type];
                }
            }
            // dd($leadSource);
            $this->leadVsSource = json_encode($leadVsSource);
            $view = view('member.dashboard.client-dashboard', $this->data)->render();
            return Reply::dataOnly(['view' => $view]);
        }
        return view('member.dashboard.client', $this->data);
    }
}
