<?php

namespace App\Http\Controllers\Test;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\MailboxService;
use App\Models\Mailbox;
use App\Models\Message;
use App\Traits\ImageUpload;

class MailboxController extends Controller
{
    use ImageUpload;

    /**
     * @var MailboxService
     */
    protected $service;

    public function __construct(
        MailboxService $service
    ) {
        $this->service = $service;
    }

    public function index()
    {
    }

    public function get($ym)
    {
        // $currentUser = auth()->guard('api')->user();
        // $where = [
        //     'clinic_id' => $currentUser->clinic->id,
        //     'month' => $ym
        // ];

        // $withdraw = $this->service->getWhere($where);

        // return response()->json([
        //     'withdraw' => $withdraw,
        // ], 200);
    }

    public function getReservation($id)
    {
        $mailbox = $this->service->get($id);
        
        return response()->json([
            'reservation' => $mailbox->reservation->load(['patient', 'clinic'])
        ]);
    }

    public function getMessages($id)
    {
        $mailbox = $this->service->get($id);

        $where = [
            'mailbox_id' => $id
        ];
        $messages = $this->service->getMessages($where);

        return response()->json([
            'messages' => $messages
        ]);
    }

    public function addMessage(Request $request, $id)
    {
        $mailbox = $this->service->get($id);
        
        foreach ($mailbox->users as $user) {
            if ($user->clinic) continue;
            $patient = $user;
        }

        \DB::beginTransaction();
        try {
            $message = $this->service->createMessage([
                'mailbox_id' => $id,
                'user_id' => $patient->id,
                'message' => $request->messages['message'],
                'is_file' => $request->messages['is_file'],
            ]);

            \DB::commit();
        } catch (\Throwable $e) {
            \DB::rollBack();
            \Log::error($e->getMessage());

            return response()->json([
                'message' => 'メッセージを送信できません。'
            ], 500);
        }

        return response()->json([
            'message' => $message->load('sender')
        ]);
    }

    public function uploadMessageFile(Request $request, $id)
    {
        $path = $this->imageUpdateWithThumb('/upload/messages', $request->file, 120);
        return response()->json([
            'photo' => $path
        ], 200);
    }
    
    public function updateFirebaseKey(Request $request, $id)
    {
        $mailbox = $this->service->get($id);
        
        foreach ($mailbox->users as $user) {
            if ($user->clinic) continue;
            $patient = $user;
        }

        $patient->firebase_key = $request->firebase_key;
        $patient->save();
    }
    
    public function getFirebaseKey($id)
    {
        $mailbox = $this->service->get($id);
        
        foreach ($mailbox->users as $user) {
            if ($user->clinic) continue;
            $patient = $user;
        }

        return response()->json([
            'firebase_key' => $patient->firebase_key
        ], 200);
    }
}
