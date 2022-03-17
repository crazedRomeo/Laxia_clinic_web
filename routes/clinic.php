<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| クリニック Routes
|--------------------------------------------------------------------------
|
| Here is where you can register SPA routes for your frontend. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "spa" middleware group.
|
*/

Route::group(['middleware' => 'guest:api'], function () {
  Route::post('login', 'Auth\LoginController@login');
  Route::post('register', 'Auth\RegisterController@register');

  // Route::post('password/email', 'Auth\ForgotPasswordController@sendResetLinkEmail');
  // Route::post('password/reset', 'Auth\ResetPasswordController@reset');

  // Route::post('email/verify/{user}', 'Auth\VerificationController@verify')->name('verification.verify');
  // Route::post('email/resend', 'Auth\VerificationController@resend');

  // Route::post('oauth/{driver}', 'Auth\OAuthController@redirectToProvider');
  // Route::get('oauth/{driver}/callback', 'Auth\OAuthController@handleProviderCallback')->name('oauth.callback');
});

Route::group(['middleware' => ['auth.clinic']], function() {
  Route::get('load/enum', 'MasterDataController@loadEnumData');
  Route::get('load/master', 'MasterDataController@loadMasterData');
  
  Route::post('/update/firebase', 'ClinicController@updateFirebaseKey');

  Route::post('/menus/photoupload', 'MenuController@uploadPhoto');
  Route::post('/menus', 'MenuController@store');
  Route::post('/menus/{id}', 'MenuController@update');
  Route::get('/menus', 'MenuController@index');
  Route::delete('/menus/{id}', 'MenuController@delete');

  Route::post('/stuffs/photoupload', 'StuffController@uploadPhoto');
  Route::post('/stuffs', 'StuffController@store');
  Route::post('/stuffs/{id}', 'StuffController@update');
  Route::get('/stuffs', 'StuffController@index');
  Route::get('/stuffs/get', 'StuffController@getAll');
  Route::delete('/stuffs/{id}', 'StuffController@delete');

  Route::post('/cases/before/photoupload', 'CaseController@uploadBeforePhoto');
  Route::post('/cases/after/photoupload', 'CaseController@uploadAfterPhoto');
  Route::post('/cases', 'CaseController@store');
  Route::post('/cases/{id}', 'CaseController@update');
  Route::get('/cases', 'CaseController@index');

  Route::get('/reservations/{id}/status/{status}', 'ReservationController@updateStatus');
  Route::get('/reservations/payments', 'ReservationController@indexWithPayments');
  Route::get('/reservations/common_data', 'ReservationController@commonData');
  Route::delete('/reservations/delete/{id}', 'ReservationController@delete');
  Route::get('/reservations/{id}', 'ReservationController@get');
  Route::get('/reservations', 'ReservationController@index');
  Route::put('/reservations/{id}', 'ReservationController@update');
  Route::put('/reservations/{id}/with-user-info', 'ReservationController@updateWithUserInfo');
  Route::post('/reservations/{id}/pay', 'ReservationController@pay');

  Route::get('/patients', 'PatientInfoController@index');
  Route::get('/patients/{id}', 'PatientInfoController@get');
  Route::get('/patients/{id}/payments', 'PatientInfoController@getPayments');
  Route::put('/patients/{id}', 'PatientInfoController@update');

  Route::post('/photoupload', 'ClinicController@uploadPhoto');
  Route::post('/company-photo-upload', 'ClinicController@uploadCompanyPhotos');
  Route::get('/getInfo', 'ClinicController@get');
  Route::put('/{id}', 'ClinicController@update');

  Route::get('/payments', 'PaymentController@index');
  Route::get('/payments/common_data', 'PaymentController@commonData');

  Route::get('/withdarws', 'WithdrawController@index');
  Route::get('/withdarws/{ym}', 'WithdrawController@get');

  Route::get('/mailboxes/common_data', 'MailboxController@commonData');
  Route::get('/mailboxes/{id}/reservation', 'MailboxController@getReservation');
  Route::get('/mailboxes/{id}/messages', 'MailboxController@getMessages');
  Route::post('/mailboxes/{id}/messages', 'MailboxController@addMessage');
  Route::post('/mailboxes/{id}/fileupload', 'MailboxController@uploadMessageFile');

  // プロフィール
  Route::get('/pref/{pref_id}/cities', 'MasterDataController@getCities');
  Route::get('/city/{id}/towns', 'MasterDataController@getTowns');

  
  Route::get('logout', 'Auth\LoginController@logout');

  Route::get('profile', 'ProfileController@get');
  Route::put('profile', 'ProfileController@update');
  Route::get('profile/{id}', 'ProfileController@getProfile');
  Route::post('profile/photoupload', 'ProfileController@uploadPhoto');
  Route::post('update/email', 'ProfileController@updateEmail');
  Route::post('update/password', 'ProfileController@updatePassword');

  Route::get('doctors', 'DoctorController@get');
  Route::post('doctors', 'DoctorController@addClinic');
  Route::delete('doctors/{id}', 'DoctorController@deleteClinic');
  Route::post('/search/doctor', 'DoctorController@search');
});
