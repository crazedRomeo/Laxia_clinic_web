<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use App\Models\TreatProgress;
use App\Services\ProgressService;
use App\Http\Requests\StuffRequest;
use App\Services\CommentService;

class ProgressController extends Controller
{
    /**
     * @var ProgressService
     */
    protected $service;

    /**
     * @var CommentService
     */
    protected $commentService;

    public function __construct(
        ProgressService $service,
        CommentService $commentService
    ) {
        $this->service = $service;
        $this->commentService = $commentService;
    }

    public function get($progress_id)
    {
        $progress = TreatProgress::find($progress_id);
        if(empty($progress))
            return response()->json([
                'progress' => []
            ], 200);

        return response()->json([
            'progress' => $progress->load([
                'diary',
                'statuses',
                'medias',
                'comments_limit50'
            ])
        ], 200);
    }

    public function update(Request $request, $progress_id)
    {
        $progress = TreatProgress::find($progress_id);
        if(empty($progress))
            return response()->json([
                'status' => 0,
                'message' => 'エラーが発生しました。',
                'errors' => ''
            ]);

        $this->authorize($progress);
        $validator = Validator::make($request->all(), [
            'progresses' => 'required|array',
            'progresses.from_treat_day' => 'required|integer',
            'progresses.content' => 'required|string',
            'medias' => 'nullable|array',
            'status' => 'required|array'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 0,
                'message' => 'エラーが発生しました。',
                'errors' => $validator->getMessageBag()->toArray()
            ]);
        }

        \DB::beginTransaction();
        try {
            $progress = $this->service->update($request->all(), ['id' => $progress->id]);

            \DB::commit();
        } catch (\Throwable $e) {
            \DB::rollBack();
            \Log::error($e->getMessage());

            return response()->json([
                'message' => 'エラーが発生しました。'
            ], 500);
        }

        return response()->json([
            'status' => 1,
            'data' => [
                'progress' => $progress
            ]
        ], 200);
    }

    public function indexComments(Request $request, $progress_id)
    {
        $progress = TreatProgress::find($progress_id);
        if(empty($progress))
            return response()->json([
                'status' => 0,
                'data' => '',
            ]);

        return response()->json([
            'status' => 1,
            'data' => $this->commentService->paginate($request->all(), $progress),
        ]);
    }
    
    public function storeComment(Request $request, $progress_id)
    {
        $progress = TreatProgress::find($progress_id);
        if(empty($progress))
            return response()->json([
                'status' => 0,
                'message' => 'エラーが発生しました。',
                'errors' => ''
            ]);

        $validator = Validator::make($request->all(), [
            'comments' => 'required|array',
            'comments.parent_id' => 'nullable|integer|exists:comments,id',
            'comments.comment' => 'required'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 0,
                'message' => 'エラーが発生しました。',
                'errors' => $validator->getMessageBag()->toArray()
            ]);
        }

        \DB::beginTransaction();
        try {
            $currentUser = auth()->guard('patient')->user();
            $patient = $currentUser->patient;
            $comment = $this->commentService->store($request->all(), $progress, ['patient_id' => $patient->id]);

            \DB::commit();
        } catch (\Throwable $e) {
            \DB::rollBack();
            \Log::error($e->getMessage());

            return response()->json([
                'message' => 'エラーが発生しました。'
            ], 500);
        }

        return response()->json([
            'status' => 1,
            'data' => [
                'comment' => $comment
            ]
        ], 200);
    }

}
