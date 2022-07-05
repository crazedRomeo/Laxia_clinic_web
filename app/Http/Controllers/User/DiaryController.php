<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Services\DiaryService;
use App\Services\Master\DiaryMasterService;
use App\Services\ViewService;
use App\Services\CommentService;
use App\Models\Diary;

class DiaryController extends Controller
{
    /**
     * @var DiaryService
     */
    protected $service;

    /**
     * @var DiaryMasterService
     */
    protected $diaryMasterService;

    /**
     * @var ViewService
     */
    protected $viewService;

    /**
     * @var CommentService
     */
    protected $commentService;

    public function __construct(
        DiaryService $service,
        DiaryMasterService $diaryMasterService,
        ViewService $viewService,
        CommentService $commentService
    ) {
        $this->service = $service;
        $this->diaryMasterService = $diaryMasterService;
        $this->viewService = $viewService;
        $this->commentService = $commentService;
    }

    public function loadMaster()
    {
        $data = $this->diaryMasterService->loadMaster();
        return response()->json([
            'status' => 1,
            'data' => $data
        ]);
    }

    public function search(Request $request)
    {
        $params = $request->all();
        $diaries = $this->service->paginate($params);

        return response()->json([
            'status' => 1,
            'data' => [
                'diaries' => $diaries
            ]
        ], 200);
    }

    public function get(Request $request, $diary_id)
    {
        $diary = Diary::find($diary_id);
        if(empty($diary))
            return response()->json([
                'status' => 0,
                'data' => [],
            ]);

        $currentUser = auth()->guard('patient')->user();
        $patient = $currentUser->patient;
        if ($patient->id != $diary->patient_id) {
            $this->viewService->view($patient, $diary);
        }
        return response()->json([
            'status' => 1,
            'data' => [
                'diary' => $diary->load([
                    'owner',
                    'categories',
                    'menus',
                    'text_questions',
                    // 'rate_questions',
                    // 'clinic',
                    // 'doctor',
                    'beforemedias',
                    'aftermedias',
                    'progresses',
                    'progresses.medias',
                ])
            ]
        ]);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'diaries' => 'required|array',
            'diaries.clinic_id' => 'required|integer|exists:clinics,id',
            'diaries.treat_date' => 'required|date',
            'diaries.doctor_id' => 'required|integer|exists:doctors,id',
            'categories' => 'required|array',
            'medias' => 'nullable|array',
            'diary_tqs' => 'required|array',
            'menus' => 'required|array',
            'menus.*.id' => 'required|integer|exists:menus,id',
            'menus.*.cost' => 'required|integer',
            'diaries.cost_anesthetic' => 'required|integer',
            'diaries.cost_drug' => 'required|integer',
            'diaries.cost_other' => 'required|integer',
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
            $diary = $this->service->store($request->all(), ['patient_id' => $patient->id]);

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
                'diary' => $diary
            ]
        ], 200);
    }

    public function update(Request $request, $diary_id)
    {
        $diary = Diary::find($diary_id);
        if(empty($diary))
            return response()->json([
                'status' => 0,
                'message' => 'エラーが発生しました。',
                'errors' => ''
            ]);

        $this->authorize($diary);
        $validator = Validator::make($request->all(), [
            'diaries' => 'required|array',
            'diaries.clinic_id' => 'required|integer|exists:clinics,id',
            'diaries.treat_date' => 'required|date',
            'diaries.doctor_id' => 'required|integer|exists:doctors,id',
            'categories' => 'required|array',
            'medias' => 'nullable|array',
            'diary_tqs' => 'required|array',
            // 'menus' => 'required|array',
            // 'menus.*.id' => 'required|integer|exists:menus,id',
            // 'menus.*.cost' => 'required|integer',
            // 'diaries.cost_anesthetic' => 'required|integer',
            // 'diaries.cost_drug' => 'required|integer',
            // 'diaries.cost_other' => 'required|integer',
            // 'diary_rqs' => 'required|array',
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
            $diary = $this->service->update($request->all(), ['id' => $diary->id]);

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
                'diary' => $diary
            ]
        ], 200);
    }

    public function storeProgress(Request $request, Diary $diary)
    {
        $currentUser = auth()->guard('patient')->user();

        if ($diary->patient_id != $currentUser->patient->id) {
            return response()->json([
                'status' => 0,
                'message' => '権限がありません。',
                'errors' => $validator->getMessageBag()->toArray()
            ]);
        }

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
            $patient = $currentUser->patient;
            $params = $request->all();
            $params["progresses"]["diary_id"] = $diary->id;
            $progress = $this->service->storeProgress($params);

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

    public function storeComment(Request $request, Diary $diary)
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
            $commet = $this->commentService->store($request->all(), $diary, ['patient_id' => $patient->id]);

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

    public function toggleLike($diary_id)
    {
        $diary = Diary::find($diary_id);
        if(empty($diary))
            return response()->json([
                'status' => 0,
                'data' => []
            ], 200);

        $patient = auth()->guard('patient')->user()->patient;
        $result = $diary->likers()->toggle($patient->id);
        return response()->json([
            'status' => 1,
            'data' => $result
        ], 200);
    }

    public function toggleFavorite($diary_id)
    {
        $diary = Diary::find($diary_id);
        if(empty($diary))
            return response()->json([
                'status' => 0,
                'data' => []
            ], 200);

        $patient = auth()->guard('patient')->user()->patient;
        $result = $diary->favoriters()->toggle($patient->id);
        return response()->json([
            'status' => 1,
            'data' => $result
        ], 200);
    }
}
