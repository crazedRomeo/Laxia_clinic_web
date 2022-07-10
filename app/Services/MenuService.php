<?php
namespace App\Services;

use Illuminate\Support\Arr;
use App\Models\Master\Category;
use App\Models\Menu;
use App\Models\Clinic;

use DB;
use Auth;
use Throwable;

/**
 * Class MenuService
 * @package App\Services
 */
class MenuService
{
  public function paginate($search)
  {
    $per_page = isset($search['per_page']) ? $search['per_page'] : 20;
    $query = Menu::query()
      ->with([
        'categories',
        'clinic',
        'images',
        'diaries',
        'process'
      ])->withCount('diaries');

    if (isset($search['clinic_id'])) {
      $query->where('menus.clinic_id', $search['clinic_id']);
    }

    if (isset($search['status'])) {
      $query->where('menus.status', $search['status']);
    } else {
      $query->where('menus.status', '1');
    }

    // if (isset($search['category_id'])) {
    //   if (is_array($search['category_id'])) {
    //     if (!empty(array_filter($search['category_id']))) {
    //       $query->whereIn('category_id', $search['category_id']);
    //     }
    //   } else if ($search['category_id'] != '-1') {
    //     $category = Category::find($search['category_id']);
    //     $ids = $category->descendantsAndSelf()->pluck('id');
    //     $query->whereIn('category_id', $ids);
    //   }
    // }
    // if (isset($search['category_id']))
    // {
    //     $query->whereHas('categories',function($suvquery) use ($search) {
    //         $suvquery->whereIn('menus_categories.id',explode(',',$search['category_id']));
    //     });
    // //   $ids = Category::whereIn('id',explode(',',$search['category_id']))->select('id')->get();
    // // //   $ids = $category->descendantsAndSelf()->pluck('id');
    // //   $query->whereHas('categories', function($subquery) use ($ids) {
    // //     $subquery->whereIn('diary_categories.category_id', $ids);
    // //   });
    // }

    // if (isset($search['category_id']) && $search['category_id'] != '-1') {
    //   $query->join('menu_categories as mc', 'menus.id', '=', 'mc.menu_id')
    //         ->where('mc.category_id', $search['category_id']);
    // }
    if (isset($search['category_id']))
    {
      $ids = Category::whereIn('id',explode(',',$search['category_id']))->select('id')->get();
    //   $ids = $category->descendantsAndSelf()->pluck('id');
      $query->whereHas('categories', function($subquery) use ($ids) {
        $subquery->whereIn('menu_categories.category_id', $ids);
      });
    }
    if (isset($search['city_id']))
    {
    // $ids = Clinic::whereIn('id',explode(',',$search['city_id']))->select('id')->get();
    //   $ids = $category->descendantsAndSelf()->pluck('id');
      $query->whereHas('clinic', function($subquery) use ($search){
        $subquery->whereIn('clinics.city_id',explode(',',$search['city_id']));
      });
    }
    if(isset($search['q']) && $search['q'] != '') {
      $query->where(function($query) use ($search) {
              $query->where('menus.name', 'like', "%{$search['q']}%")
              ->orWhere('menus.description', 'like', "%{$search['q']}%");
      });
    }
    if(isset($search['filter'])&&$search['filter']==0)
    {
        //$query->selectRaw("menus.*, IF(ISNULL(`diary_menu`.`id`), 0, COUNT(`menus`.`id`)) as diarycount")->leftJoin('diary_menu', 'menus.id', '=', 'diary_menu.menu_id')->groupBy('menus.id');
        // $result=$query->get();
        // return array_slice($result->sortByDesc('diarycount')->values()->all(),($search['page']-1)*$search['per_page'],$search['per_page']);
        $query->orderby('diaries_count', 'desc');
    }else if(isset($search['filter'])&&$search['filter']==1){
        // $result=$query->get();
        // return array_slice($result->sortBy('diarycount')->values()->all(),($search['page']-1)*$search['per_page'],$search['per_page']);
        $query->orderby('diaries_count', 'asc');
    }
    else if(isset($search['filter'])&&$search['filter']==2){
        $query->orderby('price', 'desc');
    }
    else if(isset($search['filter'])&&$search['filter']==3){
        $query->orderby('price', 'asc');
    }
    $query->orderby('created_at', 'desc');
    return $query->paginate($per_page);
  }

  public function toArray($params)
  {
    $query = Menu::query()
      ->public();
    if (isset($params['clinic_id'])) {
      $query->where('clinic_id', $params['clinic_id']);
    }
    $query->orderby('created_at', 'desc');
    return $query->get()
      ->pluck('name', 'id')
      ->toArray();
  }

  public function toArrayDetail($params)
  {
    $query = Menu::query()
      ->public();
    if (isset($params['clinic_id'])) {
      $query->where('clinic_id', $params['clinic_id']);
    }
    $query->orderby('created_at', 'desc');
    return $query->get(['id','name','price']);
  }

  public function get($id)
  {
    return Menu::with([
      'images',
      'categories',
      'diaries',
      'process'
    ])
    ->findOrFail($id);
  }

  public function store($attributes, $addtional = [])
  {
    $menuAttrs = Arr::get($attributes, 'menus');
    $data = array_merge($menuAttrs, $addtional);
    $menu =  Menu::create($data);

    $menuPhotos = Arr::get($attributes, 'menuPhotos');
    $menu->images()->delete();
    foreach ($menuPhotos as $photo) {
      $menu->images()->create([
        'path' => $photo
      ]);
    }
    foreach ($attributes['menus']['process'] as $process) {
        $menu->process()->create(
          $process
        );
      }
    $categoryAttrs = Arr::get($attributes, 'categories');
    $menu->categories()->sync($categoryAttrs);

    return $menu;
  }

  public function update($attributes, $where)
  {

    $menuAttrs = Arr::get($attributes, 'menus');
    $menu = Menu::where($where)->firstOrFail();
    $menu->update($menuAttrs);
    $menu->process()->delete();
    foreach ($attributes['menus']['process'] as $process) {
      $menu->process()->create(
        $process
      );
    }
    $menuPhotos = Arr::get($attributes, 'menuPhotos');
    $menu->images()->delete();
    foreach ($menuPhotos as $photo) {
      $menu->images()->create([
        'path' => $photo
      ]);
    }

    $categoryAttrs = Arr::get($attributes, 'categories');
    $menu->categories()->sync($categoryAttrs);

    return $menu;
  }
}
