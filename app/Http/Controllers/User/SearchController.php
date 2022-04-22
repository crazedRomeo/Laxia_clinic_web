<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\User\CaseService;
use App\Services\MenuService;
use App\Services\ClinicService;
use App\Services\DoctorService;
use App\Services\DiaryService;

class SearchController extends Controller
{
    protected $caseService;
    protected $menuService;
    protected $clinicService;
    protected $doctorService;
    protected $diaryService;

    public function __construct(
        CaseService $caseService,
        MenuService $menuService,
        ClinicService $clinicService,
        DoctorService $doctorService,
        DiaryService $diaryService
    ) {
        $this->caseService = $caseService;
        $this->menuService = $menuService;
        $this->clinicService = $clinicService;
        $this->doctorService = $doctorService;
        $this->diaryService = $diaryService;
    }

    public function search(Request $request)
    {
        $params = $request->all();
        
        $cases = $this->caseService->paginate($params);
        $menus = $this->menuService->paginate($params);
        $clinics = $this->clinicService->paginate($params);
        $doctors = $this->doctorService->paginate($params);
        $diaries = $this->diaryService->paginate($params);
        
        return response()->json([
            'cases' => $cases,
            'menus' => $menus,
            'clinics' => $clinics,
            'doctors' => $doctors,
            'diaries' => $diaries,
        ], 200);
    }
}