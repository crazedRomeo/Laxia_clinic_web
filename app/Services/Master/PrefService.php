<?php
namespace App\Services\Master;

use Illuminate\Support\Arr;
use App\Models\Master\Pref;
use App\Models\Master\City;
use App\Models\Clinic;
use DB;
use Auth;
use Throwable;

/**
 * Class PrefService
 * @package App\Services\Master
 */
class PrefService
{
  public function toArray()
  {
    return Pref::all()
      ->pluck('name', 'id')
      ->toArray();
  }

  public function getCities($pref_id)
  {
    return \DB::table('mtb_cities')
      ->select('id', 'name')
      ->where('pref_id', $pref_id)
      ->get();
  }

  public function getTowns($id)
  {
    return \DB::table('mtb_towns')
      ->select('id', 'name')
      ->where('city_id', $id)
      ->get();
  }

  public function getClinicsAreas()
  {
    // $data = Pref::with(['cities' => function($subquery) {
    //   $subquery->whereIn('name', function($subquery) {
    //     $subquery->select('addr01')
    //       ->from(with(new Clinic)->getTable())
    //       ->groupBy('addr01');
    //   });
    // }])
    //   ->whereIn('id', function($subquery) {
    //     $subquery->select('pref_id')
    //       ->from(with(new Clinic)->getTable())
    //       ->groupBy('pref_id');
    //   })
    //   ->get();
    $data = Pref::with(['cities'])->get();

    return $data;
  }
}
