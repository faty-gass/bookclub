<?php

namespace App\Http\Controllers;

use App\Book;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;


class BookController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $books= DB::table('books') 
            ->where('available',true)
            ->get();
        return $books;        
    }

    public function allBooks()
    {
        return Book::all();        
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

        // stockage dans amazon s3
        $upload = $s3->upload($bucket, $file_name, $decoded, 'public-read');

        Book::create([
            'title'=> $request->title,
            'description'=> $request->description,
            'author'=> $request->author,
            'genre'=> $request->genre,
            'user_id'=>Auth::id(),
            'image'=>$file_name
        ]);
        return response()->json([
            'status_code' => 200,
            'message' => 'Livre ajouté',
            ]);
                
    }

    public function showUserBooks(User $user)
    {
        $books= \DB::table('books') 
            ->where('user_id',$user->id)
            ->get();
        return $books;        
    }

    public function search(Request $request)
    {
        $book= DB::table('books')
            ->where('title', 'like', '%'.$request->search.'%')
            ->get();
        return $book ;     
    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Book  $book
     * @return \Illuminate\Http\Response
     */
    public function updateAvailable(Request $request, Book $book)
    {
        $updated_book = Book::find($book) ->first();
/*         $updated_book->available = $request->available ; */
        $updated_book->update(['available'=>$request->available]);
        return response()->json([
            'status_code' => 200,
            'message' => $updated_book,
        ]);
    }


    public function update(Request $request, Book $book)
    {
        $updated_book= DB::table('books')
        ->where('id',$book->id)
        ->update(['available' => $request->available]);
        return response()->json([
            'status_code' => 200,
            'message' => 'Status modifié',
        ]);
    }

    public function sort(Request $request)
    {
        $books= DB::table('books')
            ->where('genre', $request->filtre)
            ->get();
        return $books ;     
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Book  $book
     * @return \Illuminate\Http\Response
     */
    public function destroy(Book $book)
    {
        $book->delete();
        return response()->json([
            'status_code' => 200,
            'message' => "Livre supprimé",
        ]);       
    }
}
