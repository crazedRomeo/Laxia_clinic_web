<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\PatientService;
use App\Models\Patient;
use App\Http\Resources\User\Patient as PatientResource;

class PatientController extends Controller
{
    /**
     * @var PatientService
     */
    protected $service;

    public function __construct(
        PatientService $service
    ) {
        $this->service = $service;
    }

    public function index(Request $request)
    {
        $patients = $this->service->paginate($request->all());

        return PatientResource::collection($patients);
    }

    public function get(Request $request,$id)
    {
        $currentUser = auth()->guard('patient')->user();
        $patient = $currentUser->patient;
        $patient = $this->service->get($id);
        $isfollow = $this->service->IsFollow($id,$patient->id);
        $patient['isfollow']=$isfollow;
        
        return response()->json([
            'status' => 1,
            'data' => [
                'patient' => $patient
            ]
        ]);
    }

    public function getFollows(Request $request)
    {
        $currentUser = auth()->guard('patient')->user();
        $patient = $currentUser->patient;

        $params = $request->all();
        $params['patient_id'] = $patient->id;
        $follows = $this->service->getFollows($params);
        return response()->json([
            'status' => 1,
            'data' => [
                'follows' => $follows
            ]
        ]);
    }

    public function getFollowers(Request $request)
    {
        $currentUser = auth()->guard('patient')->user();
        $patient = $currentUser->patient;

        $params = $request->all();
        $params['follow_id'] = $patient->id;
        $followers = $this->service->getFollowers($params);
        return response()->json([
            'status' => 1,
            'data' => [
                'followers' => $followers
            ]
        ]);
    }

    public function toggleFollow(Request $request, Patient $patient)
    {
        $currentUser = auth()->guard('patient')->user();
        $result = $this->service->toggleFollow($currentUser->patient->id, $patient->id);

        return response()->json([
            'status' => 1,
            'data' => $result
        ]);
    }
}
