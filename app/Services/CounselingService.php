<?php
namespace App\Services;

use Illuminate\Support\Arr;
use App\Models\Master\Category;
use App\Models\CounselingReport;
use App\Models\Media;
use DB;
use Auth;
use Throwable;

/**
 * Class CounselingService
 * @package App\Services
 */
class CounselingService
{
  public function paginate($search)
  {
    $per_page = isset($search['per_page']) ? $search['per_page'] : 20;
    $query = CounselingReport::query()
      ->with([
        'medias',
        'categories'
      ]);

    if (isset($search['category_id']))
    {
      $category = Category::find($search['category_id']);
      $ids = $category->descendantsAndSelf()->pluck('id');
      $query->whereHas('categories', function($subquery) use ($ids) {
        $subquery->whereIn('counseling_categories.category_id', $ids);
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
            ->where('favoriable_type', 'App\Models\CounselingReport')
            ->where('patient_id', $patient_id);
        });
      }
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

    if (isset($search['patient_id']))
    {
      $query->where('patient_id', $search['patient_id']);
    }

    // if (isset($search['orderby'])) {
    //   $orderby = $search['orderby'];
    //   if ($orderby == 'comments_count') {
    //     $query->withCount('comments')
    //       ->orderby('comments_count', 'DESC');
    //   } else if ($orderby == 'news') {
    //     $query->orderby('updated_at', 'DESC');
    //   }
    // } else {
    //   $query->orderby('updated_at', 'desc');
    // }
    if(isset($search['filter'])&&$search['filter']==0)
    {
            //$query->selectRaw("menus.*, IF(ISNULL(`diary_menu`.`id`), 0, COUNT(`menus`.`id`)) as diarycount")->leftJoin('diary_menu', 'menus.id', '=', 'diary_menu.menu_id')->groupBy('menus.id');
        $result=$query->get();
        return array_slice($result->sortByDesc('likes_count')->values()->all(),($search['page']-1)*$search['per_page'],$search['per_page']);
    }
    else if(isset($search['filter'])&&$search['filter']==1){
        $query->orderby('updated_at', 'DESC');
    }
    $query->orderby('created_at', 'DESC');
    return $query->paginate($per_page);
  }

  public function get($id)
  {
    // return Question::findOrFail($id);
  }

  public function store($attributes, $addtional = [])
  {
    $counselingAttrs = Arr::get($attributes, 'counselings');
    $cateArr = Arr::get($attributes, 'categories');
    $mediaArr = Arr::get($attributes, 'medias');
    $questionArr = Arr::get($attributes, 'questions');

    $data = array_merge($counselingAttrs, $addtional);
    $counseling = CounselingReport::create($data);

    $counseling->categories()->sync($cateArr);

    foreach ($mediaArr as $key => $ids)
    {
      foreach ($ids as $id)
      {
        $media = Media::find($id);
        if (!$media) continue;
        $media->update(['category' => $key]);
        $counseling->medias()->save($media);
      }
    }

    foreach ($questionArr as $item)
    {
      $counseling->questions()->create([
        'question' => $item['question'],
        'answer' => $item['answer'],
      ]);
    }

    return $counseling->load([
      'categories',
      'mediaSelf',
      'mediaLike',
      'mediaDislike',
      'questions'
    ]);

    return $counseling;
  }

  public function update($attributes, $where)
  {
  }
}
