<?php

namespace App\Http\Controllers\Clinic;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\PaymentService;
use App\Services\DoctorService;
use App\Models\Payment;

class PaymentController extends Controller
{
    /**
     * @var PaymentService
     */
    protected $service;

    /**
     * @var DoctorService
     */
    protected $doctorService;

    public function __construct(
        PaymentService $service,
        DoctorService $doctorService
    ) {
        $this->service = $service;
        $this->doctorService = $doctorService;
    }

    public function index(Request $request)
    {
        $currentUser = auth()->guard('api')->user();
        $params = $request->all();
        $params['clinic_id'] = $currentUser->clinic->id;
        
        list($payments, $sum) = $this->service->paginate($params);

        return response()->json([
            'payments' => $payments,
            'sum' => $sum
        ], 200);
    }

    public function commonData(Request $request) {
        $currentUser = auth()->guard('api')->user();
        $clinic_id = $currentUser->clinic->id;

        $doctors = $this->doctorService->getDoctorsByClinic($clinic_id);

        return response()->json([
            'doctors' => $doctors,
        ], 200);
    }
}
