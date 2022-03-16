<?php

namespace App\Http\Controllers\Clinic;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\MailboxService;
use App\Services\DoctorService;
use App\Models\Mailbox;
use App\Models\Message;
use App\Traits\MediaUpload;

class MailboxController extends Controller
{
    use MediaUpload;

    /**
     * @var MailboxService
     */
    protected $service;

    /**
     * @var DoctorService
     */
    protected $doctorService;

    public function __construct(
        MailboxService $service,
        DoctorService $doctorService
    ) {
        $this->service = $service;
        $this->doctorService = $doctorService;
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

    public function commonData(Request $request) {
        $currentUser = auth()->guard('api')->user();
        $clinic_id = $currentUser->clinic->id;

        $doctors = $this->doctorService->getDoctorsByClinic($clinic_id);

        return response()->json([
            'doctors' => $doctors,
        ], 200);
    }

    public function getReservation($id)
    {
        $mailbox = $this->service->get($id);
        $this->authorize('rw', $mailbox);
        
        return response()->json([
            'reservation' => $mailbox->reservation->load(['patient', 'clinic', 'doctor', 'hopeTimes'])
        ]);
    }

    public function getMessages($id)
    {
        $mailbox = $this->service->get($id);
        $this->authorize('rw', $mailbox);

        $where = [
            'mailbox_id' => $id
        ];
        // $this->service->readLastMessage($where);
        $messages = $this->service->getMessages($where);

        return response()->json([
            'messages' => $messages
        ]);
    }

    public function addMessage(Request $request, $id)
    {
        $mailbox = $this->service->get($id);
        $this->authorize('rw', $mailbox);

        \DB::beginTransaction();
        try {
            $message = $this->service->addMessage($request->all(), ['mailbox_id' => $id]);

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
        $path = $this->mediaUploadWithThumb('/messages', $request->file, 120);
        return response()->json([
            'photo' => $path[1]
        ], 200);
    }
    
}
