//
//  HomeRouter.swift
//  MVVM-MoviesApp
//
//  Created by Victor Hugo Benitez Bosques on 8/27/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import Foundation
import UIKit

// Create the Home object and navigatino of the app (Views)
// MARK: - Create the Home objct and navigation of the app (show Views)
class HomeRouter {
    
    private var soureView : UIViewController?
    
    var viewController : UIViewController{
        return createViewController()
    }
  
    private func createViewController() -> UIViewController{
        return  HomeView()
    }
    
    // bind the router wih the viewmodel
    func setSourceView(_ vwSource : UIViewController?){
        guard let vwData = vwSource else {fatalError("set source view error")}
        self.soureView = vwData
    }
  
  func navigationDetailView(strID : String?){
    if let detailView = DetailRouter(strID).viewController as? DetailMoviewView{
      detailView.strMovieID = strID
      soureView?.navigationController?.pushViewController(detailView, animated: true)
    }
    
  }
  
}
