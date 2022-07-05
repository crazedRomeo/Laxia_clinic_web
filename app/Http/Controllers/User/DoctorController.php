<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\DoctorService;
use App\Services\ViewService;
use App\Models\Doctor;

class DoctorController extends Controller
{
    /**
     * @var DoctorService
     */
    protected $service;

    /**
     * @var ViewService
     */
    protected $viewService;

    public function __construct(
        DoctorService $service,
        ViewService $viewService
    ) {
        $this->service = $service;
        $this->viewService = $viewService;
    }

    public function search(Request $request)
    {
        $params = $request->all();
        $doctors = $this->service->paginate($params);
        return response()->json([
            'doctors' => $doctors
        ], 200);
    }

    public function get($id)
    {
        // $patient = auth()->guard('patient')->user()->patient;
        // $this->viewService->view($patient, $doctor);
        // return response()->json([
        //     'doctor' => $doctor->load([
        //         // 'specialities'
        //         'clinic',
        //         'counselings',
        //         'cases',
        //     ])
        // ], 200);
        $doctor = $this->service->get($id);
        return response()->json([
            'doctor' => $doctor
        ], 200);
    }

    public function toggleLike(Doctor $doctor)
    {
        $patient = auth()->guard('patient')->user()->patient;
        if (!isset($patient)) {
            return response()->json([
                'status' => 0,
                'message' => 'いいねすることができません',
            ], 200);
        }
        $result = $doctor->likers()->toggle($patient->id);
        return response()->json([
            'status' => 1,
            'data' => $result
        ], 200);
    }

    public function toggleFavorite(Doctor $doctor)
    {
        $patient = auth()->guard('patient')->user()->patient;
        $result = $doctor->favoriters()->toggle($patient->id);
        return response()->json([
            'status' => 1,
            'data' => $result
        ], 200);
    }

}
