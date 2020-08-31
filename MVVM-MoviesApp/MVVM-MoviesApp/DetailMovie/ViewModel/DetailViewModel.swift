//
//  DetailViewModel.swift
//  MVVM-MoviesApp
//
//  Created by Victor Hugo Benitez Bosques on 30/08/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class DetailViewModel {

  var manager : ManagerConnection = ManagerConnection()
  private var vwDetailView : DetailMoviewView?
  private var rtRouter : DetailRouter?
  
  
  func bind(_ view : DetailMoviewView, router :DetailRouter  ){
    self.vwDetailView = view
    self.rtRouter = router
    
    self.rtRouter?.setSource(view)
  }
  
  func getListMoviewData(strMovieID : String?)-> Observable<DetailMovie> {
    return manager.getDetailMovies(strId: strMovieID)
  }
  
}

