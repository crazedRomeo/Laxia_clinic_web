<?php

namespace App\Http\Controllers\Clinic;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\MenuService;
use App\Models\Menu;
use App\Http\Requests\MenuRequest;
use App\Traits\MediaUpload;
use Illuminate\Support\Str;

class MenuController extends Controller
{
    use MediaUpload;

    /**
     * @var MenuService
     */
    protected $service;

    public function __construct(
        MenuService $service
    ) {
        $this->service = $service;
    }

    public function index(Request $request)
    {
        $params = $request->all();
        $params['clinic_id'] = auth()->guard('clinic')->user()->clinic->id;
        $menus = $this->service->paginate($params);

        return response()->json([
            'menus' => $menus
        ], 200);
    }

    public function store(MenuRequest $request)
    {
        $currentUser = auth()->guard('clinic')->user()->clinic;

        \DB::beginTransaction();
        try {
            $menu = $this->service->store($request->all(), ['clinic_id' => $currentUser->id]);

            \DB::commit();
        } catch (\Throwable $e) {
            \DB::rollBack();
            \Log::error($e->getMessage());

            return response()->json([
                'message' => 'メニューを登録できません。'
            ], 500);
        }
        return response()->json([
            'menu' => $menu
        ], 200);
    }

    public function update(MenuRequest $request, $id)
    {
        $params = $request->menus;
        $menu = $this->service->get($id);
        $currentUser = auth()->guard('api')->user();
        if ($currentUser->id != $menu->clinic_id) {
            return response()->json([
                'message' => 'Permission Denied'
            ], 403);
        }

        \DB::beginTransaction();
        try {
            $menu = $this->service->update($request->all(), ['id' => $id]);

            \DB::commit();
        } catch (\Throwable $e) {
            \DB::rollBack();
            \Log::error($e->getMessage());

            return  response()->json([
                'message' => 'メニューを変更できません。'
            ], 500);
        }
        return response()->json([
            'menu' => $menu
        ], 200);
    }

    public function uploadPhoto(Request $request)
    {
        $path = $this->mediaUploadWithThumb('/clinic/menus', $request->file, 300);
        return response()->json([
            'photo' => $path[1]
        ], 200);
    }

    // public function uploadPhoto(Request $request)
    // {
    //     $uploadedFile = $request->file;
    //     // $request->validate([
    //     //     'photo' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
    //     // ]);
    //     $disk = 'public';
    //     $filename = null;
    //     $name = !is_null($filename) ? $filename : Str::random(25);
    //     $file = $uploadedFile->storeAs('/clinic/menus', $name.'.'.$uploadedFile->getClientOriginalExtension(), $disk);

    //    return response()->json([
    //        'photo' => $file,
    //    ], 200);
    // }

    public function delete($id) {
        $menu = Menu::where('id', $id)->firstOrFail();
        $menu->images()->delete();
        $menunInfo = Menu::where('id', $id);
        $menunInfo->delete();

        return true;
    }

}
