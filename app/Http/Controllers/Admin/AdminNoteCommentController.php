<?php

namespace App\Http\Controllers\Admin;

use App\Helper\Reply;
use App\Http\Requests\Tasks\StoreTaskNote;
use App\TaskNote;
use Illuminate\Http\Request;

class AdminNoteCommentController extends AdminBaseController
{
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
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreTaskNote $request)
    {
        $note = new TaskNote();
        $note->note = $request->note;
        $note->task_id = $request->taskId;
        $note->user_id = $this->user->id;
        $note->save();

        $this->notes = TaskNote::where('task_id', $request->taskId)->orderBy('id', 'desc')->get();
        $view = view('admin.tasks.task_note', $this->data)->render();
        $this->logUserActivity($this->user->id,'Task Note added');
        return Reply::dataOnly(['status' => 'success', 'view' => $view]);
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
        $note = TaskNote::findOrFail($id);
        $note_task_id = $note->task_id;
        $note->delete();
        $this->notes = TaskNote::where('task_id', $note_task_id)->orderBy('id', 'desc')->get();
        $view = view('admin.tasks.task_note', $this->data)->render();
        $this->logUserActivity($this->user->id,'Task Note removed');
        return Reply::dataOnly(['status' => 'success', 'view' => $view]);
    }
}
