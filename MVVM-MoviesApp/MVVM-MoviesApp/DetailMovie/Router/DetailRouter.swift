//
//  DetailRouter.swift
//  MVVM-MoviesApp
//
//  Created by Victor Hugo Benitez Bosques on 30/08/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import Foundation
import UIKit

class DetailRouter {
  private var sourceView : UIViewController?
  
  var strIdMovie : String?
  
  init( _ strMovieId : String? = "") {
    self.strIdMovie = strMovieId
  }
  
  var viewController : UIViewController{
    return createViewController()
  }
  
  private func createViewController() -> UIViewController{
    return  DetailMoviewView()
  }
  
  
  func setSource(_ vwSource : UIViewController?){
    guard let vwData = vwSource else {return}
    self.sourceView = vwData
  }
}
