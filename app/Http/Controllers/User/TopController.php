<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\ContentService;

class TopController extends Controller
{
    /**
     * @var ContentService
     */
    protected $service;

    public function __construct(
        ContentService $service
    ) {
        $this->service = $service;
    }

    public function search(Request $request)
    {
        $params = $request->all();
        $contents = $this->service->search($params);
        return response()->json([
            'contents' => $contents
        ], 200);
    }

}
