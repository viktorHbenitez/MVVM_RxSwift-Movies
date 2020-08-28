//
//  Movies.swift
//  MVVM-MoviesApp
//
//  Created by Victor Hugo Benitez Bosques on 27/08/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import Foundation

struct Movies : Codable {
  var  arrMovies : [Movie]
  enum CodingKeys: String, CodingKey{
     case arrMovies  =  "results"
   }
  
}


struct Movie : Codable {
  var strTitle : String
  var strPopularity : Double
  var iMovieID : Int
  var iVoteCount : Int
  var strOriginalTitle : String
  var iVoteAvarage : Double
  var strOverview : String
  var strReleaseDate : String
  var strPosterPath : String
  
  enum CodingKeys: String, CodingKey{
    case strTitle  =  "title"
    case strPopularity = "popularity"
    case iMovieID = "id"
    case iVoteCount = "vote_count"
    case strOriginalTitle = "original_title"
    case iVoteAvarage = "vote_average"
    case strOverview = "overview"
    case strReleaseDate  = "release_date"
    case strPosterPath = "poster_path"
  }
  
}
