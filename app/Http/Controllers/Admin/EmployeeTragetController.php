<?php

namespace App\Http\Controllers\Admin;

use App\EmployeeTraget;
use App\Helper\Reply;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;

class EmployeeTragetController extends AdminBaseController
{
    /**
     * ManageLeadFilesController constructor.
     */
    public function __construct() {
        parent::__construct();
        $this->pageIcon = 'icon-layers';
        $this->pageTitle = 'app.target';
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
        
        $targe = new EmployeeTraget();
        $targe->user_id = $request->user_id;
        $targe->call_w = $request->call_w;
        $targe->call_m = $request->call_m;
        $targe->visits_w = $request->visits_w;
        $targe->visits_m = $request->visits_m;
        $targe->money = $request->money;
        $targe->save();
       
        $this->employeeTarget = EmployeeTraget::where('user_id', $request->user_id)->get();

        $view = view('admin.employees.target-list', $this->data)->render();

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


    /**
     * @param Request $request
     * @param $id
     * @return array
     * @throws \Throwable
     */
    public function destroy(Request $request, $id)
    {
        $file = EmployeeDocs::findOrFail($id);

        Files::deleteFile($file->hashname,'employee-docs/'.$file->user_id);

        EmployeeDocs::destroy($id);

        $this->employeeDocs = EmployeeDocs::where('user_id', $file->user_id)->get();

        $view = view('admin.employees.docs-list', $this->data)->render();
        $this->logUserActivity($this->user->id,__('messages.fileDeleted'));
        return Reply::successWithData(__('messages.fileDeleted'), ['html' => $view]);
    }


    /**
     * @param $id
     * @return \Symfony\Component\HttpFoundation\BinaryFileResponse|\Symfony\Component\HttpFoundation\StreamedResponse
     */
    public function download($id) {
        $file = EmployeeDocs::findOrFail($id);
        return download_local_s3($file,'employee-docs/'.$file->user_id.'/'.$file->hashname);
    }

}
