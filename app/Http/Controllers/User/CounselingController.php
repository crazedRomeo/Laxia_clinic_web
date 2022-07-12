<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Services\CounselingService;
use App\Services\CommentService;
use App\Models\CounselingReport;

class CounselingController extends Controller
{
    /**
     * @var CounselingService
     */
    protected $service;

    /**
     * @var CommentService
     */
    protected $commentService;

    public function __construct(
        CounselingService $service,
        CommentService $commentService
    ) {
        $this->service = $service;
        $this->commentService = $commentService;
    }

    public function search(Request $request)
    {
        $params = $request->all();
        $counselings = $this->service->paginate($params);

        return response()->json([
            'status' => 1,
            'data' => [
                'counselings' => $counselings
            ]
        ], 200);
    }

    public function get(CounselingReport $counseling)
    {
        $currentUser = auth()->guard('patient')->user();
        $patient = $currentUser->patient;
        if ($patient->id != $counseling->patient_id) {
            // $this->viewService->view($patient, $counseling);
        }

        return response()->json([
            'status' => 1,
            'data' => [
                'counseling' => $counseling->load([
                    'mediaSelf',
                    'mediaLike',
                    'mediaDislike',
                    'questions',
                    'clinic',
                    'doctor',
                    'categories'
                ])
            ]
        ], 200);
    }

    public function store(Request $request)
    {
        $patient = auth()->guard('patient')->user()->patient;

        $validator = Validator::make($request->all(), [
            'counselings' => 'required|array',
            'counselings.clinic_id' => 'required|integer|exists:clinics,id',
            'counselings.doctor_id' => 'required|integer|exists:doctors,id',
            'counselings.counseling_date' => 'required|date',
            'counselings.content' => 'required|string',
            'counselings.reason' => 'nullable|string',
            'counselings.before_counseling' => 'required|string',
            'counselings.after_ccounseling' => 'nullable|string',
            'counselings.rate' => 'required|integer',
            'categories' => 'required|array',
            'medias' => 'nullable|array',
            'medias.self' => 'nullable|array',
            'medias.like' => 'nullable|array',
            'medias.dislike' => 'nullable|array',
            'questions' => 'nullable|array',
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
            $counseling = $this->service->store($request->all(), ['patient_id' => $patient->id]);

            \DB::commit();
        } catch (\Throwable $e) {
            \DB::rollBack();
            \Log::error($e->getMessage());

            return response()->json([
                'message' => 'メニューを登録できません。'
            ], 500);
        }
        return response()->json([
            'status' => 1,
            'data' => [
                'counseling' => $counseling
            ]
        ], 200);
    }

    public function update(MenuRequest $request, $id)
    {
    }

    public function toggleLike(CounselingReport $counseling)
    {
        $patient = auth()->guard('patient')->user()->patient;
        $result = $counseling->likers()->toggle($patient->id);
        return response()->json([
            'status' => 1,
            'data' => $result
        ], 200);
    }

    public function toggleFavorite(CounselingReport $counseling)
    {
        $patient = auth()->guard('patient')->user()->patient;
        $result = $counseling->favoriters()->toggle($patient->id);
        return response()->json([
            'status' => 1,
            'data' => $result
        ], 200);
    }

    public function indexComments(Request $request, CounselingReport $counseling)
    {
        return response()->json([
            'status' => 1,
            'data' => $this->commentService->paginate($request->all(), $counseling),
        ]);
    }

    public function storeComment(Request $request, CounselingReport $counseling)
    {
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
            $commet = $this->commentService->store($request->all(), $counseling, ['patient_id' => $patient->id]);

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
                'commet' => $commet
            ]
        ], 200);
    }
}
