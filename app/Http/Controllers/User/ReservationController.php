<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use App\Services\User\RsvService;
use App\Services\PatientInfoService;
use App\Models\Reservation;
use App\Models\PatientInfo;
use App\Http\Resources\User\Reservation as ReservationResource;

class ReservationController extends Controller
{
    /**
     * @var RsvService
     */
    protected $service;

    public function __construct(
        RsvService $service,
        PatientInfoService $patientInfoService
    ) {
        $this->service = $service;
        $this->patientInfoService = $patientInfoService;
    }

    public function index(Request $request)
    {
        $params = $request->all();
        $currentUser = auth()->guard('patient')->user();
        $patient = $currentUser->patient;
        if (!isset($patient)) $rsvs = null;
        else {
            $params['patient_id'] = $patient->id;
            $rsvs = $this->service->paginate($params);
        }

        return response()->json([
            'status' => 1,
            'data' => ReservationResource::collection($rsvs)
        ]);
    }

    public function getPatientInfo()
    {
        $currentUser = auth()->guard('patient')->user();
        if (!$currentUser || !($currentUser->patient)) return null;
        return response()->json([
            'status' => 1,
            'data' => $currentUser->patient->info
        ]);
    }

    public function store(Request $request)
    {
        $currentUser = auth()->guard('patient')->user();
        $patient = $currentUser->patient;

        $validator = Validator::make($request->all(), [
            'rsv' => 'required|array',
            'rsv.clinic_id' => 'required|integer|exists:clinics,id',
            'rsv.stuff_id' => 'nullable|integer|exists:stuffs,id',
            'rsv.source' => 'required|integer',
            'rsv.hope_treat' => 'required|integer',
            'rsv.is_visited' => 'required|integer',
            'rsv.note' => 'nullable|string',
            'rsv.use_point' => "nullable|integer|max:{$patient->point}",
            'categories' => 'required|array',
            'time' => 'required|array',
            'time.*.date' => 'nullable|date',
            'time.*.start_time' => 'nullable|date_format:H:i',
            'time.*.end_time' => 'nullable|date_format:H:i',
            'info' => 'required|array',
            'info.name01' => 'required|string',
            'info.name02' => 'required|string',
            'info.kana01' => 'required|string',
            'info.kana02' => 'required|string',
            'info.gender' => 'required|string',
            'info.phone_number' => 'required|string',
            'info.birthday' => 'required|date',
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
            $patientInfo = $this->patientInfoService->store($request->all(), ['patient_id' => $patient->id]);
            $rsv = $this->service->store($request->all(), ['patient_info_id' => $patientInfo->id]);

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
            'data' => $rsv->load([
                'hopeTimes',
                'hopeCategories',
            ])
        ], 200);
    }
}
