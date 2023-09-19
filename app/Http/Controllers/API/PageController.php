<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class PageController extends Controller
{
    /**
     * Handle the incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function __invoke(Request $request)
    {

        $pages = [
            'privacy_policy '    => "<h1> privacy_policy </h1>",
            'terms_conditions'   => "<h1> terms_conditions </h1>",
            'help_center'        => "<h1> help_center </h1>",
            'about'              => "<h1> about </h1>",
        ];
        return response()->success([
            'pages' => $pages
        ]);
    }
}
