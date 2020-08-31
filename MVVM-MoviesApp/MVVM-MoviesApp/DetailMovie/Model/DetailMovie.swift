//
//  DetailMovie.swift
//  MVVM-MoviesApp
//
//  Created by Victor Hugo Benitez Bosques on 30/08/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import Foundation

struct DetailMovie : Decodable {
  var strTitle : String
  var strDescription : String
  var strImage : String
  
  enum CodingKeys : String, CodingKey{
    case strTitle  =  "original_title"
    case strDescription  = "overview"
    case strImage = "backdrop_path"
  }
  
  
  
  var strUrl : String{
    return  Constant.URL.urlImage+strImage
  }
  
  
}
