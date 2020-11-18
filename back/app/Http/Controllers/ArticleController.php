<?php

namespace App\Http\Controllers;

use App\Article;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;


class ArticleController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Article::all();
    }


    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $s3 = new \Aws\S3\S3Client([
            'version'     => 'latest',
            'region'      => 'us-east-1',
        ]);
        $bucket = getenv('S3_BUCKET');

        //recup base6' de l'image
        $exploded = explode(',',$request->image);
        $decoded = base64_decode($exploded[1]);
        // recup l'extension
        if (Str::contains($exploded[0],'jpeg')){
            $extension='.jpg';
        } else if (Str::contains($exploded[0],'png')){
            $extension='.png';
        } else if (Str::contains($exploded[0],'gif')){
            $extension='.gif';
        }
        //creation d'un nom aléatoire
        $file_name= Str::random(8).$extension;
        // indication du path où stocker l'img
/*         $path = public_path().'/'.$file_name;
        file_put_contents($path,$decoded); */
        // stockage dans amazon s3
        //Storage::disk('s3')->put($file_name,$decoded);
        $upload = $s3->upload($bucket, $file_name, $decoded, 'public-read');

        $validator = Validator::make($request->all(),[
            'title' => ['required', 'unique:articles', 'string', 'max:255'],
        ]);
        if ($validator->fails()){
            return response()->json([
                'status_code' => 500,
                'message' => 'Error in Registration',
                'error'=> $validator->errors()
                ]);
        } else {
            Article::create([
                'title'=> $request->title,
                'summary'=> $request->summary,
                'author'=> $request->author,
                'genre'=> $request->genre,
                'edition'=> $request->edition,
                'pub_year'=>$request->pub_year,
                'user_id'=>$request->user_id,
                'image'=>$file_name
            ]);
            return response()->json([
                'status_code' => 200,
                'message' => 'Article créé',
                ]);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Article  $article
     * @return \Illuminate\Http\Response
     */
    public function show(Article $article)
    {
        return Article::find($article->id);
    }

    public function showUserArticles(User $user)
    {
        $articles= \DB::table('articles') 
            ->where('user_id',$user->id)
            ->get();
        return $articles;
    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Article  $article
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Article $article)
    {
        $validator = Validator::make($request->all(),[
            'title' => ['required', 'string', 'max:255', 'unique:articles, title'.$article->id],
        ]);
        if ($validator->fails()){
            return response()->json([
                'status_code' => 500,
                'message' => 'Error in Article modification',
                'error'=> $validator->errors()
                ]);
        } else {
            $updated_article= DB::table('articles')
            ->where('id',$article->id)
            ->update([ 'title' => $request->title,
                'summary'=>$request->summary,
                'author'=> $request->author,
                'genre'=>$request->genre,
                'edition'=>$request->edition,
                'pub_year'=>$request->pub_year,
                ]);
            return response()->json([
                'status_code' => 200,
                'message' => "Description modifiée",
            ]);
        }
    }

    public function updateImage(Request $request, Article $article)
    {
        $s3 = new \Aws\S3\S3Client([
            'version'     => 'latest',
            'region'      => 'us-east-1',
        ]);
        $bucket = getenv('S3_BUCKET');

        //recup base6' de l'image
        $exploded = explode(',',$request->image);
        $decoded = base64_decode($exploded[1]);
        // recup l'extension
        if (Str::contains($exploded[0],'jpeg')){
            $extension='.jpg';
        } else if (Str::contains($exploded[0],'png')){
            $extension='.png';
        } else if (Str::contains($exploded[0],'gif')){
            $extension='.gif';
        }
        //creation d'un nom aléatoire
        $file_name= Str::random(8).$extension;

        // stockage dans amazon s3
        $upload = $s3->upload($bucket, $file_name, $decoded, 'public-read');

        // ajout du nom image dans la DB
        $articles=Article::find($article)->first();
        $articles->update([
            "image"=>$file_name
        ]);

        return response()->json([
            'status_code' => 200,
            'message' => $articles,
            ]); 
    }


    public function search(Request $request)
    {
        $article= DB::table('articles')
            ->where('title', 'like', '%'.$request->search.'%')
            ->get();
        return $article ;     
    }


    public function sort(Request $request)
    {
        $article= DB::table('articles')
            ->where('genre', $request->filtre)
            ->get();
        return $article ;     
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Article  $article
     * @return \Illuminate\Http\Response
     */
    public function destroy(Article $article)
    {
        $article->delete();
        return response()->json([
            'status_code' => 200,
            'message' => "Article supprimé",
        ]);
    }
}
