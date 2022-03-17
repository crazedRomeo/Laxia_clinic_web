<?php

namespace App\Http\Controllers\Clinic;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\DoctorService;
use Illuminate\Support\Facades\Validator;
use App\Traits\MediaUpload;

class DoctorController extends Controller
{
    use MediaUpload;

    /**
     * @var DoctorService
     */
    protected $service;

    public function __construct(
        DoctorService $service
    ) {
        $this->service = $service;
    }
 
    public function get(Request $request) {
        $clinic_id = auth()->guard('clinic')->user()->id;

        $doctors = $this->service->getDoctorsByClinic($clinic_id);
        $cnt_h = $this->service->getDoctorsCountByClinic($clinic_id, $request);

        return response()->json([
            'status' => 1,
            'cnt_mh' => $cnt_h,
            'data' => $doctors
        ], 200);
    }

    protected function validator(array $data)
    {
        return Validator::make($data, [
            'doctor_id' => 'required|integer|exists:doctors,id',
        ]);
    }

    public function addClinic(Request $request)
    {
        $clinic_id = auth()->guard('clinic')->user()->id;
        $validator = $this->validator($request->all());

        if ($validator->fails()) {
            return response()->json([
                'status' => 0,
                'message' => 'エラーが発生しました。',
                'errors' => $validator->getMessageBag()->toArray()
            ]);
        }

        $data = $request->all();
   
        \DB::beginTransaction();
        try {
            $doctor = $this->service->setClinic($data['doctor_id'], $clinic_id);

            \DB::commit();
        } catch (\Throwable $e) {
            \DB::rollBack();
            \Log::error($e->getMessage());

            return response()->json([
                'status' => 0,
                'message' => 'ドクターを追加できません。'
            ], 500);
        }

        return response()->json([
            'status' => 1,
            'doctor' => $doctor
        ], 200);
    }

    public function deleteClinic(Request $request, $id)
    {
        \DB::beginTransaction();
        try {
            $doctor = $this->service->deleteClinic($id);

            \DB::commit();
        } catch (\Throwable $e) {
            \DB::rollBack();
            \Log::error($e->getMessage());

            return response()->json([
                'status' => 0,
                'message' => 'ドクターを削除できません。'
            ], 500);
        }

        return response()->json([
            'status' => 1,
            'id' => $doctor
        ], 200);
    }

    public function search(Request $request)
    {
        $doctors = $this->service->search($request->all());

        return response()->json([
            'status' => 1,
            'data' => $doctors
        ]);
    } 
}
