<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Comment;
use App\Article;
use App\User;
use Faker\Generator as Faker;

$factory->define(Comment::class, function (Faker $faker) {
    $users=User::all()->pluck('id')->toArray();
    $articles=Article::all()->pluck('id')->toArray();
    return [
        'comment'=> $faker->text(300),
        'article_id'=>$faker->randomElement($articles),
        'user_id'=>$faker->randomElement($users),
    ];
});
