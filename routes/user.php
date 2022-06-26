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


Route::get('load/master', 'MasterDataController@loadMasterData');
Route::get('menus', 'MenuController@index');
Route::get('clinics', 'ClinicController@search');
Route::get('stuffs', 'StuffController@search');
Route::get('doctors', 'DoctorController@search');
Route::get('diaries', 'DiaryController@search');
Route::get('counselings', 'CounselingController@search');
Route::get('questions', 'QuestionController@search');
Route::get('cases', 'CaseController@index');

// 検索


Route::group(['middleware' => 'guest:api'], function () {
  Route::post('login', 'Auth\LoginController@login');
  Route::post('login/sns', 'Auth\RegisterController@registerWithSocial');
  Route::post('register/email/{unique_id?}', 'Auth\RegisterController@register');

  Route::post('password/email', 'Auth\ForgotPasswordController@sendResetLinkEmail');
  Route::post('password/reset', 'Auth\ResetPasswordController@reset');

  // Route::post('email/verify/{user}', 'Auth\VerificationController@verify')->name('verification.verify');
  // Route::post('email/resend', 'Auth\VerificationController@resend');

  // Route::post('oauth/{driver}', 'Auth\OAuthController@redirectToProvider');
  // Route::get('oauth/{driver}/callback', 'Auth\OAuthController@handleProviderCallback')->name('oauth.callback');
});

Route::group(['middleware' => ['auth.patient']], function() {
  Route::post('register/detail', 'ProfileController@registerDetail');
  Route::get('me', 'ProfileController@me');
  Route::get('search', 'SearchController@search');
  Route::get('midsearch', 'SearchController@midsearch');
  Route::get('globalsearch', 'SearchController@globalsearch');
  Route::get('recentsearch', 'SearchController@recentsearch');

  // ファイル（画像、動画など）
  Route::post('media', 'MediaController@upload');

  // 投稿
  Route::get('diray/master/load', 'DiaryController@loadMaster');
  Route::post('counselings', 'CounselingController@store');

  // 日記
  Route::post('diaries', 'DiaryController@store');
  Route::get('diaries/{diary}', 'DiaryController@get');
  Route::put('diaries/{diary}', 'DiaryController@update');
  Route::post('diaries/{diary}/toggleLike', 'DiaryController@toggleLike');
  Route::post('diaries/{diary}/toggleFavorite', 'DiaryController@toggleFavorite');

  // 日記経過
  Route::post('diaries/{diary}/progresses', 'DiaryController@storeProgress');
  Route::get('progresses/{progress}', 'ProgressController@get');
  Route::put('progresses/{progress}', 'ProgressController@update');
  Route::get('progresses/{progress}/comments', 'ProgressController@indexComments');
  Route::post('progresses/{progress}/comments', 'ProgressController@storeComment');

  // カウンセレポ
  Route::get('counselings/{counseling}', 'CounselingController@get');
  Route::post('counselings/{counseling}/toggleLike', 'CounselingController@toggleLike');
  Route::post('counselings/{counseling}/toggleFavorite', 'CounselingController@toggleFavorite');
  Route::get('counselings/{counseling}/comments', 'CounselingController@indexComments');
  Route::post('counselings/{counseling}/comments', 'CounselingController@storeComment');

  // 質問
  Route::post('questions', 'QuestionController@store');
  Route::get('questions/{question}', 'QuestionController@get');
  Route::post('questions/{question}/toggleLike', 'QuestionController@toggleLike');
  Route::post('questions/{question}/toggleFavorite', 'QuestionController@toggleFavorite');
  Route::get('questions/{question}/comments', 'QuestionController@indexComments');
  Route::post('questions/{question}/comments', 'QuestionController@storeComment');

  //  フォローする
  Route::post('patients/{patient}/toggleFollow', 'PatientController@toggleFollow');

  // フォロー・フォロワー
  Route::get('follows', 'PatientController@getFollows');
  Route::get('followers', 'PatientController@getFollowers');

  // ユーザーアカウント
  Route::get('patients', 'PatientController@index');
  Route::get('patients/{patient}', 'PatientController@get');

  // クリニック詳細
  Route::get('clinics/{id}', 'ClinicController@get');
  Route::post('clinics/{clinic}/toggleFavorite', 'ClinicController@toggleFavorite');

  // 症例
  Route::get('cases/{case}', 'CaseController@get');

  //スタッフ
  Route::get('stuffs/{stuff}', 'StuffController@get');
  Route::post('stuffs/{stuff}/toggleLike', 'StuffController@toggleLike');
  Route::post('stuffs/{stuff}/toggleFavorite', 'StuffController@toggleFavorite');

  // ドクター
  Route::get('doctors/{doctor}', 'DoctorController@get');
  Route::post('doctors/{doctor}/toggleLike', 'DoctorController@toggleLike');
  Route::post('doctors/{doctor}/toggleFavorite', 'DoctorController@toggleFavorite');

  // 予約
  Route::get('reservations', 'ReservationController@index');
  Route::get('reservations/patientInfo', 'ReservationController@getPatientInfo');
  Route::post('reservations', 'ReservationController@store');

  // メニュー
  Route::get('menus/{menu}', 'MenuController@get');
  Route::post('menus/{menu}/toggleFavorite', 'MenuController@toggleFavorite');

  // メッセージ
  Route::get('mailboxs/{mailbox}/messages', 'MailboxController@getMessages');
  Route::post('mailboxs/{mailbox}/messages', 'MailboxController@addMessage');

  // マスター
  Route::get('load/areas', 'MasterDataController@getAreas');
  Route::get('load/recommend', 'MasterDataController@getRecommend');

  // ポイント
  Route::get('points/history', 'PointController@getHistory');
});

// HOME
Route::get('tops', 'TopController@search');
