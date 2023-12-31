<?php

namespace App\Http\Controllers\Admin;

use App\ExpensesCategory;
use App\Helper\Reply;
use App\Http\Requests\Expenses\StoreExpenseCategory;
use Illuminate\Http\Request;

class ManageExpenseCategoryController extends AdminBaseController
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

    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $this->categories = ExpensesCategory::all();
        return view('admin.expense-category.create', $this->data);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function createCat()
    {
        $this->categories = ExpensesCategory::all();
        return view('admin.expenses.create-category', $this->data);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreExpenseCategory $request)
    {
        $category = new ExpensesCategory();
        $category->category_name = $request->category_name;
        $category->save();
        $this->logUserActivity($this->user->id, __('messages.categoryAdded'));
        return Reply::success(__('messages.categoryAdded'));
    }


    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function storeCat(StoreExpenseCategory $request)
    {
        $category = new ExpensesCategory();
        $category->category_name = $request->category_name;
        $category->save();
        $categoryData = ExpensesCategory::all();
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
        ExpensesCategory::destroy($id);
        $this->logUserActivity($this->user->id, __('messages.categoryDeleted'));
        return Reply::success(__('messages.categoryDeleted'));
    }
}
