<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\User\CaseService;
use App\Http\Requests\CaseRequest;
use App\Models\TreatCase;

class CaseController extends Controller
{
    /**
     * @var CaseService
     */
    protected $service;

    public function __construct(
        CaseService $service
    ) {
        $this->service = $service;
    }

    public function index(Request $request)
    {
        $cases = $this->service->paginate($request->all());
        return response()->json([
            'cases' => $cases
        ], 200);
    }

    public function get(TreatCase $case)
    {
        return response()->json([
            'case' => $case->load([
                'clinic', 'categories', 'menus', 'doctor'
            ])
        ], 200);
    }

    public function store(CaseRequest $request)
    {
        $currentUser = auth()->guard('clinic')->user()->clinic;

        \DB::beginTransaction();
        try {
            $case = $this->service->store($request->all(), ['clinic_id' => $currentUser->id]);

            \DB::commit();
        } catch (\Throwable $e) {
            \DB::rollBack();
            \Log::error($e->getMessage());

            return response()->json([
                'message' => '症例を登録できません。'
            ], 500);
        }
        return response()->json([
            'case' => $case
        ], 200);
    }

    public function update(CaseRequest $request, $id)
    {
        \DB::beginTransaction();
        try {
            $case = $this->service->update($request->all(), ['id' => $id]);

            \DB::commit();
        } catch (\Throwable $e) {
            \DB::rollBack();
            \Log::error($e->getMessage());

            return response()->json([
                'message' => '症例を変更できません。'
            ], 500);
        }
        return response()->json([
            'case' => $case
        ], 200);
    }

    public function uploadPhoto(Request $request)
    {
        // dd($request->file);
        $path = $this->imageUpdateWithThumb('/upload/cases', $request->file, 350);
        return response()->json([
            'photo' => $path
        ], 200);
    }
    
}
