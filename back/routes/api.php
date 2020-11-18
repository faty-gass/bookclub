<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});
Route::middleware('auth:api')->get('/logout', 'AuthController@logout');

Route::resources([
    'users' => 'UserController',
    'articles' => 'ArticleController',
    'books' => 'BookController',
]);

Route::get('/articles/{article}/comments','CommentController@showComment');
Route::get('/allBooks','BookController@allBooks');
Route::middleware('auth:api')->post('/articles/{article}/comments','CommentController@store');
Route::middleware('auth:api')->post('/books','BookController@store');
Route::get('/users/{user}/articles','ArticleController@showUserArticles');
Route::get('/users/{user}/books','BookController@showUserBooks');
Route::put('/users/{user}','UserController@updateAvatar');
Route::put('/articles/{article}','ArticleController@updateImage');
Route::put('/articles','ArticleController@sendImage');
Route::post('/articles-search', 'ArticleController@search');
Route::post('/books-search', 'BookController@search');
Route::delete('/comments/{comment}', 'CommentController@destroy');
Route::post('/books/{book}', 'BookController@updateAvailable');
Route::post('/books-sort', 'BookController@sort');
Route::post('/articles-sort', 'ArticleController@sort');