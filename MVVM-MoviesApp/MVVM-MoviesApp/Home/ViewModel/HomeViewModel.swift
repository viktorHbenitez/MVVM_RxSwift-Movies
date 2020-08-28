//
//  HomeViewModel.swift
//  MVVM-MoviesApp
//
//  Created by Victor Hugo Benitez Bosques on 8/27/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import Foundation
import RxSwift
class HomeViewModel {
  
  // 1. property of the View
  private weak var view : HomeView?
  // 2. property of the Router
  private var router : HomeRouter?
  private var bsManagerConnection : ManagerConnection = ManagerConnection()
  
  // this is the initial method
  // bind the router to the view
  func bind( view : HomeView, router : HomeRouter){
    self.view = view
    self.router = router
    self.router?.setSourceView(view)
  }
  
  func getListMovieData() -> Observable<[Movie]>{
    return bsManagerConnection.getPopularMovies()
  }
  
}
