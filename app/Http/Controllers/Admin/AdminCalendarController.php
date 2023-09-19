<?php

namespace App\Http\Controllers\Admin;

use App\Task;
use App\TaskboardColumn;

class AdminCalendarController extends AdminBaseController
{
    public function __construct()
    {
        parent::__construct();
        $this->pageTitle = 'app.menu.taskCalendar';
        $this->pageIcon = 'icon-calender';
        $this->middleware(function ($request, $next) {
            if (!in_array('tasks', $this->user->modules)) {
                abort(403);
            }
            return $next($request);
        });
    }

    public function index()
    {
        $startDate = now($this->global->timezone)->startOfYear()->toDateString();
        $endDate = now($this->global->timezone)->toDateString();

        $this->tasks = Task::select('tasks.*')
            ->join('task_users', 'task_users.task_id', '=', 'tasks.id')
            ->where(function ($q) use ($startDate, $endDate) {
                $q->whereBetween(\DB::raw('DATE(tasks.`due_date`)'), [$startDate, $endDate]);

                $q->orWhereBetween(\DB::raw('DATE(tasks.`start_date`)'), [$startDate, $endDate]);
            })
            ->groupBy('tasks.id')
            ->get();
        return view('admin.task-calendar.index', $this->data);
    }

    public function show($id)
    {
        $this->task = Task::findOrFail($id);
        return view('admin.task-calendar.show', $this->data);
    }
}
