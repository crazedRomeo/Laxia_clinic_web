<?php

namespace App\Http\Controllers\Clinic;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Enums\Common\Gender;
use App\Enums\Reservation\Type;
use App\Enums\Reservation\Status;
use App\Enums\Menu\Masui;
use App\Enums\Menu\Bleeding;
use App\Enums\Menu\HospitalNeed;
use App\Enums\Menu\HospitalVisit;
use App\Enums\Menu\Makeup;
use App\Enums\Menu\Massage;
use App\Enums\Menu\Pain;
use App\Enums\Menu\Shower;
use App\Enums\Menu\SportImpossible;
use App\Enums\Menu\Basshi;
use App\Enums\Menu\Hare;
use App\Enums\Menu\TreatTime;
use App\Enums\Menu\RequiredTime;
use App\Enums\Reservation\HopeTreat;
use App\Services\Master\JobService;
use App\Services\Master\RsvContentService;
use App\Services\Master\SpecialityService;
use App\Services\Master\CategoryService;
use App\Services\Master\PrefService;
use App\Services\StuffService;
use App\Services\MenuService;

class MasterDataController extends Controller
{

    /**
     * @var JobService
     */
    protected $jobService;

    /**
     * @var StuffService
     */
    protected $stuffService;

    /**
     * @var MenuService
     */
    protected $menuService;

    /**
     * @var SpecialityService
     */
    protected $specialityService;

    /**
     * @var RsvContentService
     */
    protected $rsvContentService;

    /**
     * @var CategoryService
     */
    protected $categoryService;

    /**
     * @var PrefService
     */
    protected $prefService;

    public function __construct(
        JobService $jobService,
        StuffService $stuffService,
        MenuService $menuService,
        SpecialityService $specialityService,
        CategoryService $categoryService,
        PrefService $prefService,
        RsvContentService $rsvContentService
    ) {
        $this->jobService = $jobService;
        $this->stuffService = $stuffService;
        $this->menuService = $menuService;
        $this->specialityService = $specialityService;
        $this->categoryService = $categoryService;
        $this->prefService = $prefService;
        $this->rsvContentService = $rsvContentService;
    }

    /**
     *
     * @param  \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     *
     */
    public function loadEnumData(Request $request)
    {
        $genders = Gender::asList();
        $rsv_type = Type::asList();
        $rsv_status = Status::asList();
        $masui = Masui::asList();
        $bleeding = Bleeding::asList();
        $hospitalNeed = HospitalNeed::asList();
        $hospitalVisit = HospitalVisit::asList();
        $makeup = Makeup::asList();
        $massage = Massage::asList();
        $pain = Pain::asList();
        $shower = Shower::asList();
        $sportImpossible = SportImpossible::asList();
        $basshi = Basshi::asList();
        $hare = Hare::asList();
        $treatTime = TreatTime::asList();
        $requiredTime = RequiredTime::asList();
        $hopeTreat = HopeTreat::asList();

        return response()->json([
            'genders' => $genders,
            'rsv_type' => $rsv_type,
            'rsv_status' => $rsv_status,
            'masui' => $masui,
            'bleeding' => $bleeding,
            'hospital_need' => $hospitalNeed,
            'hospital_visit' => $hospitalVisit,
            'makeup' => $makeup,
            'massage' => $massage,
            'pain' => $pain,
            'shower' => $shower,
            'sport_impossible' => $sportImpossible,
            'basshi' => $basshi,
            'hare' => $hare,
            'treat_time' => $treatTime,
            'required_time' => $requiredTime,
            'hope_treat' => $hopeTreat,
        ], 200);
    }

    public function loadMasterData(Request $request)
    {
        $params = [
            'clinic_id' => auth()->guard('api')->check() ? auth()->guard('api')->user()->id : ''
        ];
        $jobs = $this->jobService->toArray();
        $rsvContents = $this->rsvContentService->toArray();
        $specialities = $this->specialityService->toArray();
        $categories = $this->categoryService->toArray();
        $prefs = $this->prefService->toArray();
        $stuffs = $this->stuffService->toArray($params);
        $menus = $this->menuService->toArray($params);
        $menuDetails = $this->menuService->toArrayDetail($params);

        return response()->json([
            'jobs' => $jobs,
            'rsvContents' => $rsvContents,
            'specialities' => $specialities,
            'categories' => $categories,
            'prefs' => $prefs,
            'stuffs' => $stuffs,
            'menus' => $menus,
            'menuDetails' => $menuDetails
        ], 200);
    }

    public function getCities($pref_id)
    {
        return $this->prefService->getCities($pref_id);
    }

    public function getTowns($id)
    {
        return $this->prefService->getTowns($id);
    }
}
