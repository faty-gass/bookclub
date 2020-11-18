<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use App\User;


class AuthController extends Controller
{
    public function logout(Request $request)
    {
      auth()->user()->tokens->each(function($token, $key){
        $token->delete();
      });

      return response()->json([
          'status_code' => 200,
          'message' => 'Logged out',
          ]);
    }

}
