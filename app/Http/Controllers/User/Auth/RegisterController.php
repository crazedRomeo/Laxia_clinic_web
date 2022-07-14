<?php

namespace App\Http\Controllers\User\Auth;

use App\Http\Controllers\Controller;
use App\Providers\RouteServiceProvider;
use App\Services\Helpers\EmailService;
use Illuminate\Foundation\Auth\RegistersUsers;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use App\Services\UserService;
use App\Services\User\ProfileService;
use App\Enums\User\Type as UserType;
use App\Models\User;
use App\Jobs\UserVerifyEmailJob;
use App\Models\Patient;
use App\Models\PointHistory;
use App\Enums\Common\PointType;

// use App\Mail\User\VerifyEmail;

class RegisterController extends Controller
{
    protected $service;
    protected $profileService;

    /*
    |--------------------------------------------------------------------------
    | Register Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles the registration of new users as well as their
    | validation and creation. By default this controller uses a trait to
    | provide this functionality without requiring any additional code.
    |
    */

    use RegistersUsers;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct(
        UserService $service,
        ProfileService $profileService
    ) {
        $this->middleware('guest');
        $this->service = $service;
        $this->profileService = $profileService;
    }

    /**
     * Get a validator for an incoming registration request.
     *
     * @param  array  $data
     * @return \Illuminate\Contracts\Validation\Validator
     */
    protected function validator(array $data)
    {
        $user = User::where('email', $data['email'])
            ->where('is_active', 0)
            ->first();
        
        if (isset($user)) {
            $user->delete();
        }

        return Validator::make($data, [
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            // 'password' => ['required', 'string', 'min:8', 'confirmed'],
            'password' => ['required', 'string', 'min:8'],
        ]);
    }

    /**
     * Create a new user instance after a valid registration.
     *
     * @param  array  $data
     * @return \App\Models\User
     */
    protected function create(array $data)
    {
        return User::create([
            'email' => $data['email'],
            'password' => Hash::make($data['password']),
            'role' => UserType::USER,
            'is_active' => 1
            // 'confirmation_code' => sha1(time()),
        ]);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Http\RedirectResponse|\Illuminate\Routing\Redirector
     */
    public function register(Request $request, $unique_id = null)
    {   
        $validator = $this->validator($request->all());

        if ($validator->fails()) {
            return response()->json([
                'status' => 0,
                'message' => 'エラーが発生しました。',
                'errors' => $validator->getMessageBag()->toArray()
            ]);
        }

        $user = $this->create($request->all());

        // UserVerifyEmailJob::dispatch($user);
        if(!empty($unique_id)) {
            $patient = Patient::where('unique_id', $unique_id)->first();
            if(!empty($patient)) {
                PointHistory::create([
                    'patient_id' => $patient->id,
                    'type' => PointType::USER_INVITATION,
                    'type_id' => $user->id,
                    'use_point' => config('constants.user_invitation')
                ]);
                $patient->increment('point',3000);
            }
        }

        return response()->json([
            'status' => 1,
            'message' => '',
            'data' => $user
        ]);
    }

    public function registerWithSocial(Request $request)
    {
        $params = $request->all();
        $user = User::where([
                'email' => $params['users']['email'],
                'provider' => $params['users']['provider'],
                'provider_id' => $params['users']['provider_id'],
            ])
            ->first();

        if (!$user) {
            $validator = Validator::make($request->all(), [
                'users.email' => ['required', 'email', 'max:255', 'unique:users'],
                'users.provider' => ['required', 'string', 'in:apple,facebook,twitter'],
                'users.provider_id' => ['required', 'string', 'max:255'],
            ]);
            if ($validator->fails()) {
                return response()->json([
                    'status' => 0,
                    'message' => 'ユーザーを登録できません。',
                    'errors' => $validator->getMessageBag()->toArray()
                ]);
            }
            $user = User::create([
                'email' => $params['users']['email'],
                'provider' => $params['users']['provider'],
                'provider_id' => $params['users']['provider_id'],
                'role' => UserType::USER,
                'is_active' => 1,
            ]);
        }
            
        Auth::guard('patient')->setToken(
            $token = Auth::guard('patient')->login($user)
        );
        
        return response()->json([
            'status' => 1,
            'data' => [
                'token' => $token
            ]
        ]);
    }

    public function verifyUser($code)
    {
        if (!$code) {
            return abort('404');
        }

        $user = User::where('confirmation_code', $code)->first();

        if (!$user) {
            return abort('404');
        }
        
        \DB::beginTransaction();
        try {
            $attrs = [
                'users' => [
                    'confirmation_code' => null,
                    'is_active' => 1
                ]
            ];
            $user = $this->service->update($attrs, ['id' => $user->id]);

            \DB::commit();
        } catch (\Throwable $e) {
            \DB::rollBack();
            \Log::error($e->getMessage());

            return response()->json([
                'status' => 0,
                'message' => 'ユーザー情報を変更できません。'
            ]);
        }

        return redirect()->route('user.register.complete_email');
    }

    public function complete()
    {
        return view('user.register.complete_email');
    }
}
