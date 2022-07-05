<?php

namespace App\Http\Controllers\Clinic;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\ClinicService;
use App\Services\UserService;
use App\Http\Requests\Clinic\ClinicRequest;
use App\Traits\MediaUpload;

class ClinicController extends Controller
{
    use MediaUpload;

    /**
     * @var ClinicService
     */
    protected $service;

    /**
     * @var UserService
     */
    protected $userService;

    public function __construct(
        ClinicService $service,
        UserService $userService
    ) {
        $this->service = $service;
        $this->userService = $userService;
    }

    public function get()
    {
        $clinic = auth()->guard('clinic')->user()->clinic;
        return response()->json([
            'clinic' => $clinic->load(['images', 'pref'])
        ]);
    }

    public function update(ClinicRequest $request, $id)
    {

        $clinic = $this->service->get($id);
        \DB::beginTransaction();
        try {
            $clinic = $this->service->update($request->all(), ['id' => $id]);

            \DB::commit();
        } catch (\Throwable $e) {
            \DB::rollBack();
            \Log::error($e->getMessage());

            return response()->json([
                'message' =>$e->getMessage()
            ], 500);
        }
        return response()->json([
            'clinic' => $clinic->load('images')
        ], 200);
    }

    public function updateFirebaseKey(Request $request)
    {
        \DB::beginTransaction();
        try {
            $attrs = [
                'users' => [
                    'firebase_key' => $request->firebase_key
                ]
            ];

            $user = $this->userService->update($attrs, ['id' => auth()->user()->id]);

            \DB::commit();
        } catch (\Throwable $e) {
            \DB::rollBack();
            \Log::error($e->getMessage());

            return response()->json([
                'message' => 'エラー'
            ], 500);
        }
        return response()->json([
            'user' => $user
        ], 200);
    }

    public function uploadPhoto(Request $request)
    {
        $path = $this->mediaUploadWithThumb('/clinic/clinics', $request->file, 150);
        return response()->json([
            'photo' => $path[1]
        ], 200);
    }

    public function uploadCompanyPhotos(Request $request)
    {
        $path = $this->mediaUploadWithThumb('/clinic/companies', $request->file, 150);
        return response()->json([
            'photo' => $path[1]
        ], 200);
    }

}
