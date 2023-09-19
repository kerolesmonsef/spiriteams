<?php

namespace App\Http\Controllers\Admin;

use App\EmployeeTragetCurrnet;
use App\Helper\Reply;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;

class EmployeeTragetCurrentController extends AdminBaseController
{
    /**
     * ManageLeadFilesController constructor.
     */
    public function __construct() {
        parent::__construct();
        $this->pageIcon = 'icon-layers';
        $this->pageTitle = 'app.targetcurrent';
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }


    /**
     * @param Request $request
     * @return array
     * @throws \GuzzleHttp\Exception\GuzzleException
     * @throws \Throwable
     */
    public function store(Request $request)
    {
        
        $targe = new EmployeeTragetCurrnet();
        $targe->user_id = $request->user_id;
        $targe->date = $request->date;
        $targe->total = $request->total;
        $targe->save();
       
        $this->employeeTargetCurrent = EmployeeTragetCurrnet::where('user_id', $request->user_id)->get();

        $view = view('admin.employees.targetcurrent-list', $this->data)->render();

        $this->logUserActivity($this->user->id,__('messages.fileUploaded'));
        return Reply::successWithData(__('messages.fileUploaded'), ['html' => $view]);
        
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
//        $this->lead = Lead::findOrFail($id);
//        return view('admin.lead.lead-files.show', $this->data);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }


}
