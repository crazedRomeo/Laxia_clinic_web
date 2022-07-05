<?php
namespace App\Services;

use Illuminate\Support\Arr;
use App\Models\Master\Category;
use App\Models\RecentSearch;
use App\Models\Search;
use DB;
use Auth;
use Throwable;

/**
 * Class QuestionService
 * @package App\Services
 */
class SearchService
{
  public function globalsearch(){
    return Search::orderby('followcount','desc')->limit(20)->get();
  }
  public function recentsearch($patient_id){
    return RecentSearch::where('patient_id','=',$patient_id)->orderby('updated_at','desc')->limit(20)->get();
  }
  public function store($search,$patient_id)
  {
    $globalsearch = Search::where(
        'text',$search['q']
    )->first();
    if(!$globalsearch){
        $search_glo=new Search();
        $search_glo->text=$search['q'];
        $search_glo->save();
        $search_id = Search::where(
            'text',$search['q']
        )->first()->id;
        $recent_search=new RecentSearch();
        $recent_search->patient_id=$patient_id;
        $recent_search->search_id=$search_id;
        $recent_search->save();
    }else{
        $recent_log = RecentSearch::where([
            ['patient_id','=',$patient_id],
            ['search_id','=',$globalsearch->id]
        ])->first();
        if($recent_log){
            RecentSearch::where(
                'id','=',$recent_log->id
            )->update(['patient_id' => $patient_id]);
        }
    }
  }
}
