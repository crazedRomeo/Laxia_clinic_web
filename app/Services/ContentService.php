<?php
namespace App\Services;

use Illuminate\Support\Arr;
use Illuminate\Support\Collection;
use Illuminate\Pagination\Paginator;
use Illuminate\Pagination\LengthAwarePaginator;
use App\Models\User;
use App\Models\Diary;
use App\Models\CounselingReport;
use App\Models\Question;
use App\Models\Master\Category;
use DB;
use Auth;
use Throwable;

/**
 * Class ContentService
 * @package App\Services
 */
class ContentService
{
  public function search($params)
  {
    $per_page = isset($params['per_page']) ? $params['per_page'] : 20;
    $cateIds = null;
    if (isset($params['category_id'])) {
      $category = Category::find($params['category_id']);
      if (isset($category)) {
        $cateIds = $category->descendantsAndSelf()
          ->pluck('id')
          ->toArray();
      }
    }
    // ①日記
    $diary_comments = \DB::table('comments')
      ->select('commentable_id', DB::raw('count(commentable_id) as count'))
      ->where('commentable_type', 'App\Models\Diary')
      ->groupBy('commentable_id');
    $diary_views = \DB::table('viewables')
      ->select('viewable_id', DB::raw('count(viewable_id) as count'))
      ->where('viewable_type', 'App\Models\Diary')
      ->groupBy('viewable_id');

    // 初期画像
    $max_medias = \DB::table('medias')
      ->select('mediable_id', DB::raw('max(medias.id) as max_id'))
      ->where('mediable_type', 'App\Models\Diary')
      ->groupBy('mediable_id');
    $media1_query = \DB::table('medias')
      ->select('medias.mediable_id', 'thumb_path')
      ->joinSub($max_medias, 'first_medias', function($join) {
        $join->on('medias.id', '=', 'first_medias.max_id');
      });

    // 日記_経過がない場合
    $first_content_query = \DB::table('diary_text_questions')
      ->select('diary_id', 'answer')
      ->where('question_id', '1');

    // 日記_経過
    $progress_medias = \DB::table('medias')
      ->select('mediable_id', DB::raw('max(medias.id) as max_id'))
      ->join('treat_progresses', 'treat_progresses.id', '=', 'medias.mediable_id')
      ->where('medias.mediable_type', 'App\Models\TreatProgress')
      ->join('diaries', 'diaries.id', '=', 'treat_progresses.diary_id')
      ->whereNotNull('medias.thumb_path')
      ->groupBy('mediable_id');
    $media2_query = \DB::table('medias')
      ->select('treat_progresses.diary_id', 'thumb_path', 'content')
      ->join('treat_progresses', 'treat_progresses.id', '=', 'medias.mediable_id')
      ->joinSub($progress_medias, 'progress_medias', function($join) {
        $join->on('treat_progresses.id', '=', 'progress_medias.mediable_id');
      });

    $diaries_query = \DB::table('diaries')
      ->join('patients', 'patients.id', '=', 'diaries.patient_id')
      ->join('clinics', 'clinics.id', '=', 'diaries.clinic_id')
      ->leftJoinSub($diary_comments, 'comments_count', function ($join) {
        $join->on('diaries.id', '=', 'comments_count.commentable_id');
      })
      ->leftJoinSub($diary_views, 'views_count', function ($join) {
        $join->on('diaries.id', '=', 'views_count.viewable_id');
      })
      ->leftJoinSub($media1_query, 'media1', function ($join) {
        $join->on('diaries.id', '=', 'media1.mediable_id');
      })
      ->leftJoinSub($media2_query, 'media2', function ($join) {
        $join->on('diaries.id', '=', 'media2.diary_id');
      })
      ->leftJoinSub($first_content_query, 'first_content', function ($join) {
        $join->on('diaries.id', '=', 'first_content.diary_id');
      });

    if (isset($cateIds)) {
      $cate_subquery = \DB::table('diary_categories')
        ->select('diary_id')
        ->whereIn('category_id', $cateIds)
        ->groupBy('diary_id');
      $diaries_query->joinSub($cate_subquery, 'cate_query', function($join) {
        $join->on('diaries.id', '=', 'cate_query.diary_id');
      });
    }

    $diaries_query->select(
        'diaries.id',
        'patients.id as patient_id',
        'patients.nickname as nickname',
        'patients.photo as photo',
        'clinics.name as clinic',
        'clinics.id as clinic_id',
        'first_content.answer as first_content',
        'media2.content as last_content',
        'media1.thumb_path as first_thumb_path',
        'media2.thumb_path as last_thumb_path',
        'comments_count.count as comments_count',
        'views_count.count as views_count',
        'diaries.updated_at',
        \DB::raw("'diary' as type")
      );


    // ②カウンセレポ
    $cr_comments = \DB::table('comments')
      ->select('commentable_id', DB::raw('count(commentable_id) as count'))
      ->where('commentable_type', 'App\Models\CounselingReport')
      ->groupBy('commentable_id');
    $cr_views = \DB::table('viewables')
      ->select('viewable_id', DB::raw('count(viewable_id) as count'))
      ->where('viewable_type', 'App\Models\CounselingReport')
      ->groupBy('viewable_id');

    $medias = \DB::table('medias')
      ->select('mediable_id', DB::raw('min(medias.id) as min_id'))
      ->join('counseling_reports', 'counseling_reports.id', '=', 'medias.mediable_id')
      ->where('medias.mediable_type', 'App\Models\CounselingReport')
      ->where('medias.category', 'self')
      ->groupBy('mediable_id');
    $media_query = \DB::table('medias')
      ->select('medias.mediable_id', 'thumb_path')
      ->joinSub($medias, 'sub_medias', function($join) {
        $join->on('medias.id', '=', 'sub_medias.min_id');
      });


    $cr_query = \DB::table('counseling_reports')
      ->join('patients', 'patients.id', '=', 'counseling_reports.patient_id')
      ->join('clinics', 'clinics.id', '=', 'counseling_reports.clinic_id')
      ->leftJoinSub($cr_comments, 'comments_count', function ($join) {
        $join->on('counseling_reports.id', '=', 'comments_count.commentable_id');
      })
      ->leftJoinSub($cr_views, 'views_count', function ($join) {
        $join->on('counseling_reports.id', '=', 'views_count.viewable_id');
      })
      ->leftJoinSub($media_query, 'medias', function ($join) {
        $join->on('counseling_reports.id', '=', 'medias.mediable_id');
      });

    if (isset($cateIds)) {
      $cate_subquery = \DB::table('counseling_categories')
        ->select('counseling_id')
        ->whereIn('category_id', $cateIds)
        ->groupBy('counseling_id');
      $cr_query->joinSub($cate_subquery, 'cate_query', function($join) {
        $join->on('counseling_reports.id', '=', 'cate_query.counseling_id');
      });
    }
    $cr_query->select(
        'counseling_reports.id',
        'patients.id as patient_id',
        'patients.nickname as nickname',
        'patients.photo as photo',
        'clinics.name as clinic',
        'clinics.id as clinic_id',
        'counseling_reports.content as first_content',
        'counseling_reports.content as last_conetnt',
        'medias.thumb_path as first_thumb_path',
        'medias.thumb_path as last_thumb_path',
        'comments_count.count as comments_count',
        'views_count.count as views_count',
        'counseling_reports.updated_at',
        \DB::raw("'counserepo' as type")
      );

    // ③質問
    $q_comments = \DB::table('comments')
      ->select('commentable_id', DB::raw('count(commentable_id) as count'))
      ->where('commentable_type', 'App\Models\Question')
      ->groupBy('commentable_id');
    $q_views = \DB::table('viewables')
      ->select('viewable_id', DB::raw('count(viewable_id) as count'))
      ->where('viewable_type', 'App\Models\Question')
      ->groupBy('viewable_id');

    $medias = \DB::table('medias')
      ->select('mediable_id', DB::raw('min(medias.id) as min_id'))
      ->join('questions', 'questions.id', '=', 'medias.mediable_id')
      ->where('medias.mediable_type', 'App\Models\Question')
      ->groupBy('mediable_id');
    $media_query = \DB::table('medias')
      ->select('medias.mediable_id', 'thumb_path')
      ->joinSub($medias, 'sub_medias', function($join) {
        $join->on('medias.id', '=', 'sub_medias.min_id');
      });

    $q_query = \DB::table('questions')
      ->join('patients', 'patients.id', '=', 'questions.patient_id')
      ->leftJoinSub($q_comments, 'comments_count', function ($join) {
        $join->on('questions.id', '=', 'comments_count.commentable_id');
      })
      ->leftJoinSub($q_views, 'views_count', function ($join) {
        $join->on('questions.id', '=', 'views_count.viewable_id');
      })
      ->leftJoinSub($media_query, 'medias', function ($join) {
        $join->on('questions.id', '=', 'medias.mediable_id');
      });

    if (isset($cateIds)) {
      $cate_subquery = \DB::table('question_categories')
        ->select('question_id')
        ->whereIn('category_id', $cateIds)
        ->groupBy('question_id');
      $q_query->joinSub($cate_subquery, 'cate_query', function($join) {
        $join->on('questions.id', '=', 'cate_query.question_id');
      });
    }
    $q_query->select(
        'questions.id',
        'patients.id as patient_id',
        'patients.nickname as nickname',
        'patients.photo as photo',
        \DB::raw("NULL as clinic"),
        \DB::raw("NULL as clinic_id"),
        'questions.content as first_content',
        'questions.content as last_content',
        'medias.thumb_path as first_thumb_path',
        'medias.thumb_path as last_thumb_path',
        'comments_count.count as comments_count',
        'views_count.count as views_count',
        'questions.updated_at',
        \DB::raw("'question' as type")
      );

    $query = $diaries_query->union($cr_query)
      ->union($q_query)
      ->orderby('updated_at', 'desc');

    $result = $query->paginate($per_page);
    foreach ($result->items() as $item)
    {
      $obj = '';
      if ($item->type == 'diary') {
        $obj = Diary::find($item->id);
      } else if ($item->type == 'counserepo') {
        $obj = CounselingReport::find($item->id);
      } else if ($item->type == 'question') {
        $obj = Question::find($item->id);
      }
      $item->categories = $obj->categories;
    }

    return $result;
  }
}
