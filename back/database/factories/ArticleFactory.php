<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Article;
use App\User;
use Faker\Generator as Faker;


$factory->define(Article::class, function (Faker $faker) {
    $users=User::all()->pluck('id')->toArray();
    $genres=array('education','thriller','policier','developpement personnel');
    return [
        'title'=> $faker->text(50),
        'summary'=> $faker->text(300),
        'author'=> $faker->name,
        'genre'=> $faker->randomElement($genres),
        'edition'=> $faker->text(20),
        'pub_year'=>'1990',
        'user_id'=>$faker->randomElement($users),
    ];
});
