<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Storage;
//use \App;
//use Aws\S3\S3Client;


class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return User::all();
    }


    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {     
        $validator = Validator::make($request->all(),[
            'name' => ['required', 'unique:users', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            'password' => ['required', 'string', 'min:6'],
        ]);
        if ($validator->fails()){
            return response()->json([
                'status_code' => 500,
                'message' => 'Error in Registration',
                'error'=> $validator->errors()
                ]);
        } else {
            User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
            ]);
            return response()->json([
                'status_code' => 200,
                'message' => 'Utilisateur créé',
                ]);
        }   

    }

    /**
     * Display the specified resource.
     *
     * @param  \App\User  $user
     * @return \Illuminate\Http\Response
     */
    public function show(User $user)
    {
        return User::find($user->id);
    }



    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\User  $user
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, User $user)
    {
        $validator = Validator::make($request->all(),[
            'name' => ['string', 'max:255', 'unique:users, name'.$user->id],
            'email' => ['email', 'max:255', 'unique:users, email'.$user->id],
        ]);
        if ($validator->fails()){
            return response()->json([
                'status_code' => 500,
                'message' => 'Error in User update',
                'error'=> $validator->errors()
                ]);
        } else {
            $updated_article= DB::table('users')
            ->where('id',$user->id)
            ->update(['name' => $request->name,
                'email' => $request->email,
                ]);
            return response()->json([
                'status_code' => 200,
                'message' => "Informations modifiées",
            ]); 
        }       
    }


    public function updateAvatar(Request $request, User $user)
    {

        $s3 = new \Aws\S3\S3Client([
            'version'     => 'latest',
            'region'      => 'us-east-1',
        ]);
        $bucket = getenv('S3_BUCKET');
        
        //recup base6' de l'image
        $exploded = explode(',',$request->avatar);
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
        file_put_contents($path,$decoded);  */
    // ------------------------  stockage dans amazon s3 ---------------------------
        // FIXME: you should not use 'name' for the upload, since that's the original filename from the user's computer - generate a random filename that you then store in your database, or similar
        //$client->upload('bucket', 'key', 'object body', 'public-read');
        $upload = $s3->upload($bucket, $file_name, $decoded, 'public-read');
        //Storage::disk('s3')->put($file_name,$decoded);
        // ajout du nom image dans la DB
        $users=User::find($user)->first();
        $users->avatar= $file_name;
        $users->update();

        return response()->json([
            'status_code' => 200,
            'message' => 'avatar modifié',
            ]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\User  $user
     * @return \Illuminate\Http\Response
     */
    public function destroy(User $user)
    {
        $user->delete();
        return response()->json([
            'status_code' => 200,
            'message' => "User supprimé",
        ]);   
    }
}
