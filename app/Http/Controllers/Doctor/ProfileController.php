<?php

namespace App\Http\Controllers\Doctor;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\Request;
use App\Http\Requests\Doctor\ProfileRequest;
use App\Services\DoctorService;
use App\Services\UserService;
use App\Http\Requests\Doctor\DoctorRequest;
use App\Traits\MediaUpload;
use App\Models\Doctor;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Hash;

class ProfileController extends Controller
{
    use MediaUpload;

    /**
     * @var DoctorService
     */
    protected $service;

    /**
     * @var UserService
     */
    protected $userService;

    public function __construct(
        DoctorService $service,
        UserService $userService
    ) {
        $this->service = $service;
        $this->userService = $userService;
    }

    public function get()
    {
        // $doctor = auth()->guard('doctor')->user()->doctor;
        // return response()->json([
        //     'doctor' => $doctor->load(['images', 'pref'])
        // ]);
        $user_id = auth()->guard('doctor')->user()->id;
        // $doctor = $request->user();
        $profile = $this->service->get($user_id);

        return response()->json([
            'status' => 1,
            'data' => $profile
        ]);
    }

    public function getProfile(Request $request, $id)
    {   
        $profile = $this->service->get($id);
        return response()->json([
            'status' => 1,
            'data' => $profile
        ]);
    }

    public function update(ProfileRequest $request)
    {
        $user_id = auth()->guard('doctor')->user()->id;
        $data = $request->all();

        \DB::beginTransaction();
        try {            
            $doctor = $this->service->update($data, ['doctor_id' => $user_id]);
            $name = $this->userService->updateName($data['name'], $user_id);
            $profile = $this->service->get($user_id);

            \DB::commit();
        } catch (\Throwable $e) {
            \DB::rollBack();
            \Log::error($e->getMessage());

            return response()->json([
                'status' => 0,
                'message' => 'プロフィールは変更できません。',
                'error' => $e->getMessage()
            ], 500);
        }

        if ($name == true) {
            return response()->json([
                'status' => 1,
                'data' => $profile
            ]);
        } else {
            return response()->json([
                'status' => 0,
                'message' => 'The given data was invalid.',
                'errors' => ["name" => "ID名の値は既に存在しています。" ]
            ], 500);
        }
    }

    public function uploadPhoto(Request $request)
    {
        $uploadedFile = $request->file('photo');
        $request->validate([
            'photo' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        $disk = 'public';
        $filename = null;
        $name = !is_null($filename) ? $filename : Str::random(25);
        $file = $uploadedFile->storeAs('/doctor/profile', $name.'.'.$uploadedFile->getClientOriginalExtension(), $disk);

        return response()->json([
            'status' => 1,
            'photo' => $file,
        ]);
    }   

    protected function emailValidator(array $data)
    {
        return Validator::make($data, [
            'email' => 'required|email|max:255|unique:users',
        ]);
    }

    public function updateEmail(Request $request)
    {   
        $validator = $this->emailValidator($request->all());

        if ($validator->fails()) {
            return response()->json([
                'status' => 0,
                'message' => 'エラーが発生しました。',
                'errors' => $validator->getMessageBag()->toArray()
            ], 500);
        }

        $user_id = auth()->guard('doctor')->user()->id;
        $data = $request->all();
        $this->userService->update(['users' => ['email' => $data['email']]], ['id' => $user_id]);
        $profile = $this->service->get($user_id);

        return response()->json([
            'status' => 1,
            'data' => $profile
        ]);
    }


    protected function passwordValidator(array $data)
    {
        return Validator::make($data, [
            'current_password' => 'required|min:6',
            'new_password' => 'required|min:6|confirmed',
        ]);
    }

    public function updatePassword(Request $request)
    {   
        $validator = $this->passwordValidator($request->all());

        if ($validator->fails()) {
            return response()->json([
                'status' => 0,
                'message' => 'エラーが発生しました。',
                'errors' => $validator->getMessageBag()->toArray()
            ], 500);
        }

        $user_id = auth()->guard('doctor')->user()->id;
        $data = $request->all();
        if (Hash::check($data['current_password'], $user->password) == false) {
            return response()->json([
                'status' => 0,
                'message' => 'エラーが発生しました。',
                'errors' => ['current_password' => ['現在のパスワードが間違っています。']]
            ], 500);
        }

        $profile = $this->userService->update(['users' => ['password' => bcrypt($data['new_password'])]], ['id' => $user_id]);
        return response()->json([
            'status' => 1,
            'data' => $user
        ]);
    }
}
