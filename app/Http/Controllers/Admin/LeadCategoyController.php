<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\LeadCategory;
use App\Helper\Reply;
use App\Http\Requests\Lead\StoreLeadCategory;

class LeadCategoyController extends AdminBaseController
{

    public function __construct() {
        parent::__construct();
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
        $this->categories = LeadCategory::all();
        return view('admin.lead.create-category', $this->data);
    }
   
    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreLeadCategory $request)
    {
        $category = new LeadCategory();
        $category->category_name = $request->category_name;
        $category->save();
        $categoryData = LeadCategory::all();
        $this->logUserActivity($this->user->id, __('messages.categoryAdded'));
        return Reply::successWithData(__('messages.categoryAdded'),['data' => $categoryData]);
    }
 
    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
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
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        LeadCategory::destroy($id);
        $categoryData = LeadCategory::all();
        $this->logUserActivity($this->user->id, __('messages.categoryDeleted'));
        return Reply::successWithData(__('messages.categoryDeleted'),['data' => $categoryData]);
    }
}
