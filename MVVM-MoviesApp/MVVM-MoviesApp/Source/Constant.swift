//
//  Constant.swift
//  MVVM-MoviesApp
//
//  Created by Victor Hugo Benitez Bosques on 8/27/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

struct Constant {
    static let apiKey = "?api_key=d42ba768f459c34eadb1c87039308cbb"
    struct URL {
        static let main = "https://api.themoviedb.org/"
        static let urlImage = "https://image.tmdb.org/t/p/w200"
    }
    struct Endpoints {
        static let urlPopularMovies = "3/movie/popular"
        static let urlDetailMovie = "3/moview"
    }
}
