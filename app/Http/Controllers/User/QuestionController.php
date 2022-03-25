<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Services\QuestionService;
use App\Services\ViewService;
use App\Services\CommentService;
use App\Models\Question;
use App\Traits\MediaUpload;

class QuestionController extends Controller
{
    use MediaUpload;

    /**
     * @var QuestionService
     */
    protected $service;

    /**
     * @var ViewService
     */
    protected $viewService;

    /**
     * @var CommentService
     */
    protected $commentService;

    public function __construct(
        QuestionService $service,
        ViewService $viewService,
        CommentService $commentService
    ) {
        $this->service = $service;
        $this->viewService = $viewService;
        $this->commentService = $commentService;
    }

    public function search(Request $request)
    {
        $params = $request->all();
        $questions = $this->service->paginate($params);

        return response()->json([
            'status' => 1,
            'data' => [
                'questions' => $questions
            ]
        ], 200);
    }

    public function get(Question $question)
    {
        $currentUser = auth()->guard('patient')->user();
        $patient = $currentUser->patient;
        if ($patient->id != $question->patient_id) {
            $this->viewService->view($patient, $question);
        }

        return response()->json([
            'status' => 1,
            'data' => [
                'question' => $question->load([
                    'owner',
                    'categories',
                    'medias',
                    'comments_limit50',
                ])
            ]
        ], 200);
    }

    public function store(Request $request)
    {
        $patient = auth()->guard('patient')->user()->patient;

        $validator = Validator::make($request->all(), [
            'questions' => 'required|array',
            'questions.title' => 'required|string|max:255',
            'questions.content' => 'required|string',
            'categories' => 'required|array',
            'medias' => 'nullable|array'
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
            $question = $this->service->store($request->all(), ['patient_id' => $patient->id]);

            \DB::commit();
        } catch (\Throwable $e) {
            \DB::rollBack();
            \Log::error($e->getMessage());

            return response()->json([
                'message' => '質問を登録できません。'
            ], 500);
        }
        return response()->json([
            'status' => 1,
            'data' => [
                'question' => $question
            ]
        ], 200);
    }

    public function update(MenuRequest $request, $id)
    {
        $params = $request->menus;
        $menu = $this->service->get($id);
        $currentUser = auth()->guard('api')->user();
        if ($currentUser->id != $menu->clinic_id) {
            return response()->json([
                'message' => 'Permission Denied'
            ], 403);
        }

        \DB::beginTransaction();
        try {
            $menu = $this->service->update($request->all(), ['id' => $id]);

            \DB::commit();
        } catch (\Throwable $e) {
            \DB::rollBack();
            \Log::error($e->getMessage());

            return  response()->json([
                'message' => 'メニューを変更できません。'
            ], 500);
        }
        return response()->json([
            'menu' => $menu
        ], 200);
    }

    public function uploadPhoto(Request $request)
    {
        $path = $this->imageUpdateWithThumb('/upload/menus', $request->file, 350);
        return response()->json([
            'photo' => $path
        ], 200);
    }

    public function toggleLike(Question $question)
    {
        $patient = auth()->guard('patient')->user()->patient;
        $result = $question->likers()->toggle($patient->id);
        return response()->json([
            'status' => 1,
            'data' => $result
        ], 200);
    }

    public function toggleFavorite(Question $question)
    {
        $patient = auth()->guard('patient')->user()->patient;
        $result = $question->favoriters()->toggle($patient->id);
        return response()->json([
            'status' => 1,
            'data' => $result
        ], 200);
    }

    public function indexComments(Request $request, Question $question)
    {
        return response()->json([
            'status' => 1,
            'data' => $this->commentService->paginate($request->all(), $question),
        ]);
    }
    
    public function storeComment(Request $request, Question $question)
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
            $comment = $this->commentService->store($request->all(), $question, ['patient_id' => $patient->id]);

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
