<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Article extends Model
{
    protected $table='articles';
    public $timestamps=true;
    protected $fillable = [
        'title', 'summary', 'author', 'genre', 'edition', 'pub_year', 'user_id', 'image',
    ];
}
