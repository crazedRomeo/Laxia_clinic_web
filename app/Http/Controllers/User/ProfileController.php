<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Services\User\ProfileService;
use App\Http\Requests\User\ProfileRequest;
use App\Traits\MediaUpload;
use App\Http\Resources\Me as MeResource;
use App\Models\Patient;

class ProfileController extends Controller
{
    use MediaUpload;

    /**
     * @var ProfileService
     */
    protected $service;

    public function __construct(
        ProfileService $service
    ) {
        $this->service = $service;
    }

    public function me()
    {
        return $this->service->get(auth()->guard('patient')->user()->patient->id);
        // return new MeResource(auth()->guard('patient')->user()->patient);
    }

    public function registerDetail(Request $request) {
        $currentUser = auth()->guard('patient')->user();
        $patient = $currentUser->patient;
        $validator = Validator::make($request->all(), [
            'patients' => ['required', 'array'],
            'patients.unique_id' => 'required|string|unique:patients,unique_id,'. $patient->id .'|max:255',
            'patients.nickname' => 'required|string|max:255',
            'patients.birthday' => 'nullable|date',
            'patients.intro' => 'nullable|string',
            'patients.area_id' => 'nullable|integer|exists:mtb_prefs,id',
            'medias' => 'nullable|file|image',
            'patient_categories' => 'nullable|array'
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

            $params = $request->all();
            if ($request->file('medias')) {
                $pathInfo = $this->mediaUploadWithThumb('/user/patients', $request->medias, 150);
                $params['patients']['photo'] = $pathInfo[1];
            }
            
            $patient = $this->service->update($params, ['id' => $patient->id]);
            \DB::commit();
        } catch (\Throwable $e) {
            \DB::rollBack();
            \Log::error($e->getMessage());

            return response()->json([
                'status' => 0,
                'message' => 'プロフィールを登録できません。'
            ]);
        }

        return response()->json([
            'status' => 1,
            'data' => $patient
        ]);
    }
    
}
