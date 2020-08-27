//
//  HomeViewModel.swift
//  MVVM-MoviesApp
//
//  Created by Victor Hugo Benitez Bosques on 8/27/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    // 1. property of the View
    private weak var view : HomeView?
    // 2. property of the Router
    private var router : HomeRouter?
    
    
    // this is the initial method
    // bind the router to the view
    func bind( view : HomeView, router : HomeRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
}
