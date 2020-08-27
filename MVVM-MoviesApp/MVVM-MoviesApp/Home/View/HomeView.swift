//
//  HomeView.swift
//  MVVM-MoviesApp
//
//  Created by Victor Hugo Benitez Bosques on 8/27/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

class HomeView: UIViewController {

    private var router : HomeRouter = HomeRouter()
    private var viewModel : HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
    }
}
