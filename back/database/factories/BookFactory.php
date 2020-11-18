<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Book;
use App\Article;
use App\User;
use Faker\Generator as Faker;

$factory->define(Book::class, function (Faker $faker) {
    $users=User::all()->pluck('id')->toArray();
    $genres=array('education','roman','jeunesse','vie quotidienne');
    $articles=Article::all()->pluck('id')->toArray();
    return [
        'title'=> $faker->text(30),
        'author'=>$faker->name,
        'description'=> $faker->text(80),
        'genre'=>$faker->randomElement($genres),
        'user_id'=>$faker->randomElement($users),
        'image'=>'default_book.png'
    ];
});
