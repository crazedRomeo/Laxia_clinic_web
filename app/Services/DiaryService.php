<?php
namespace App\Services;

use Illuminate\Support\Arr;
use App\Models\Diary;
use App\Models\TreatProgress;
use App\Models\Master\Category;
use App\Models\Media;
use DB;
use Auth;
use Throwable;

/**
 * Class DiaryService
 * @package App\Services
 */
class DiaryService
{
  public function paginate($search)
  {
    $per_page = isset($search['per_page']) ? $search['per_page'] : 20;
    $query = Diary::query()
      ->with([
        'categories'
      ])->withCount('likers');

      if (isset($search['category_id']))
      {
    //     $ids = Category::whereIn('id',explode(',',$search['category_id']))->select('id')->get();
    //   //   $ids = $category->descendantsAndSelf()->pluck('id'); 
    //     $query->whereHas('categories', function($subquery) use ($ids) {
    //       $subquery->whereIn('diary_categories.category_id', $ids);
    //     });
        $query->whereHas('categories',function($suvquery) use ($search) {
        $suvquery->whereIn('diary_categories.id',explode(',',$search['category_id']));
    });
      }

    if (isset($search['favorite']) && $search['favorite'] == 1)
    {
      $currentUser = auth()->guard('patient')->user();
      if (isset($currentUser) && isset($currentUser->patient)) {
        $patient_id = $currentUser->patient->id;
        $query->whereIn('id', function($subquery) use ($patient_id) {
          $subquery->select('favoriable_id')
            ->from('favorites')
            ->where('favoriable_type', 'App\Models\Diary')
            ->where('patient_id', $patient_id);
        });
      }
    }

    if (isset($search['patient_id']))
    {
      $query->where('patient_id', $search['patient_id']);
    }

    if (isset($search['pref_id'])) {
      $pref_id = $search['pref_id'];
      $query->whereHas('clinic', function($subquery) use ($pref_id) {
        $subquery->where('pref_id', $pref_id);
      });
    }

    // if (isset($search['city'])) {
    //   $city = $search['city'];
    //   $query->whereHas('clinic', function($subquery) use ($city) {
    //     $subquery->where('addr01', "LIKE", "%{$city}%");
    //   });
    // }

    if (isset($search['price_min'])) {
      $query->where('price', '>=', $search['price_min']);
    }

    if (isset($search['price_max'])) {
      $query->where('price', '<=', $search['price_max']);
    }

    if (isset($search['menu_id'])) {
      $menuId = $search['menu_id'];
      $query->whereHas('menus', function ($subquery) use ($menuId) {
        $subquery->where('menus.id', $menuId);
      });
    }

    if (isset($search["rate"])) {
      $rate = $search["rate"];
      $query->where('ave_rate', '<=', $rate)
        ->where('ave_rate', '>', $rate - 1);
    }

    // if (isset($search['orderby'])) {
    //   $orderby = $search['orderby'];
    //   if ($orderby == 'ave_rate') {
    //     $query->orderby('ave_rate', 'DESC');
    //   } else if ($orderby == 'comments_count') {
    //     $query->withCount('comments')
    //       ->orderby('comments_count', 'DESC');
    //   } else if ($orderby == 'news') {
    //     $query->orderby('updated_at', 'DESC');
    //   }
    // }
    if(isset($search['filter'])&&$search['filter']==0)
    {
            //$query->selectRaw("menus.*, IF(ISNULL(`diary_menu`.`id`), 0, COUNT(`menus`.`id`)) as diarycount")->leftJoin('diary_menu', 'menus.id', '=', 'diary_menu.menu_id')->groupBy('menus.id');
        // $result=$query->get();
        // return array_slice($result->sortByDesc('likes_count')->values()->all(),($search['page']-1)*$search['per_page'],$search['per_page']);
        $query->orderby('likers_count', 'DESC');
    }
    elseif(isset($search['filter'])&&$search['filter']==1)
    {
        $query->orderby('ave_rate', 'DESC');
    }else if(isset($search['filter'])&&$search['filter']==2){
        $query->orderby('updated_at', 'DESC');
    }
    return $query->paginate($per_page);
  }

  public function store($attributes, $additional = [])
  {
    $diaryAttrs = Arr::get($attributes, 'diaries');
    $diaryAttrs = array_merge($diaryAttrs, $additional);
    $diaryAttrs['ave_rate'] = round((
        $diaryAttrs['rate_01']
        + $diaryAttrs['rate_02']
        + $diaryAttrs['rate_03']
        + $diaryAttrs['rate_04']
        + $diaryAttrs['rate_05']
        + $diaryAttrs['rate_06']
        + $diaryAttrs['rate_07']
        + $diaryAttrs['rate_08']
        + $diaryAttrs['rate_09']
      ) / 9, 1);

    $menuAttrs = Arr::get($attributes, 'menus');

    $menuPriceSum = 0;
    foreach ($menuAttrs as $item) {
      $menuPriceSum += $item["cost"];
    }
    $diaryAttrs['price'] = $menuPriceSum + $diaryAttrs["cost_anesthetic"] + $diaryAttrs["cost_drug"] + $diaryAttrs["cost_other"];
    $diary = Diary::create($diaryAttrs);

    $categoryAttrs = Arr::get($attributes, 'categories');
    $diary->categories()->sync($categoryAttrs);


    $menuPivot = [];
    foreach ($menuAttrs as $item) {
      $menuPivot[$item['id']] = [
        'cost' => $item['cost']
      ];
    }
    $diary->menus()->sync($menuPivot);

    $mediaAttrs = Arr::get($attributes, 'medias');
    foreach ($mediaAttrs as $id)
    {
      $media = Media::find($id);
      if (!$media) continue;
      $diary->medias()->save($media);
    }

    $textQustionAttrs = Arr::get($attributes, 'diary_tqs');
    foreach ($textQustionAttrs as $key => $val)
    {
      $diary->text_questions()->attach($key, ['answer' => $val]);
    }

    return $diary->load([
        'categories',
        'medias',
        'menus',
        // 'rate_questions',
        'text_questions',
      ]);
  }

  public function update($attributes, $where)
  {
    $diary = Diary::where($where)->firstOrFail();

    $diaryAttrs = Arr::get($attributes, 'diaries');
    $diaryAttrs['ave_rate'] = round((
        $diaryAttrs['rate_01']
        + $diaryAttrs['rate_02']
        + $diaryAttrs['rate_03']
        + $diaryAttrs['rate_04']
        + $diaryAttrs['rate_05']
        + $diaryAttrs['rate_06']
        + $diaryAttrs['rate_07']
        + $diaryAttrs['rate_08']
        + $diaryAttrs['rate_09']
      ) / 9, 1);
    $diary->update($diaryAttrs);

    $categoryAttrs = Arr::get($attributes, 'categories');
    $diary->categories()->sync($categoryAttrs);

    $menuAttrs = Arr::get($attributes, 'menus');
    $diary->menus()->sync($menuAttrs);

    $diary->medias()->delete();
    $mediaAttrs = Arr::get($attributes, 'medias');
    foreach ($mediaAttrs as $id)
    {
      $media = Media::find($id);
      if (!$media) continue;
      $diary->medias()->save($media);
    }

    // $diary->rate_questions()->sync([]);
    // $rateQustionAttrs = Arr::get($attributes, 'diary_rqs');
    // foreach ($rateQustionAttrs as $key => $val)
    // {
    //   $diary->rate_questions()->attach($key, ['rate' => $val]);
    // }

    $diary->text_questions()->sync([]);
    $textQustionAttrs = Arr::get($attributes, 'diary_tqs');
    foreach ($textQustionAttrs as $key => $val)
    {
      $diary->text_questions()->attach($key, ['answer' => $val]);
    }

    return $diary->load([
        'categories',
        'medias',
        'menus',
        // 'rate_questions',
        'text_questions',
      ]);
  }

  public function storeProgress($attributes, $additional = [])
  {
    $progressAttrs = Arr::get($attributes, 'progresses');
    $progressAttrs = array_merge($progressAttrs, $additional);
    $progress = TreatProgress::create($progressAttrs);

    $mediaAttrs = Arr::get($attributes, 'medias');
    foreach ($mediaAttrs as $id)
    {
      $media = Media::find($id);
      if (!$media) continue;
      $progress->medias()->save($media);
    }

    $statusAttrs = Arr::get($attributes, 'status');
    foreach ($statusAttrs as $key => $value)
    {
      $progress->statuses()->attach($key, ['value' => $value]);
    }

    return $progress->load([
      'medias',
      'statuses'
    ]);
  }

  public function storeComment($attributes, $additional = [])
  {
    $commentAttrs = Arr::get($attributes, 'comments');
    $commentAttrs = array_merge($commentAttrs, $additional);
    $progress = TreatProgress::create($progressAttrs);

    $mediaAttrs = Arr::get($attributes, 'medias');
    foreach ($mediaAttrs as $id)
    {
      $media = Media::find($id);
      if (!$media) continue;
      $progress->medias()->save($media);
    }

    $statusAttrs = Arr::get($attributes, 'status');
    foreach ($statusAttrs as $key => $value)
    {
      $progress->statuses()->attach($key, ['value' => $value]);
    }

    return $progress->load([
      'medias',
      'statuses'
    ]);
  }
}
