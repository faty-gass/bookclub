<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Book extends Model
{
    protected $table='books';
    public $timestamps=true;
    protected $fillable = [
        'title', 'description', 'author', 'genre', 'user_id', 'available', 'image',
    ];
}
