//
//  UIImage+imageFromService.swift
//  MVVM-MoviesApp
//
//  Created by Victor Hugo Benitez Bosques on 29/08/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView{
  
  func imageFromServerURL(from strUrl : String){
   
    if self.image == nil{
      self.image = "placeholderMovie".placeholder
    }
    
    guard let url = URL(string: strUrl) else { return}
    
    URLSession.shared.dataTask(with: url){ data, response, error in
      
      guard let data = data,
        let _ = response,
        error == nil else { return }
      
      DispatchQueue.main.async {
        // parse the dat into uiimage
        self.image = UIImage(data: data)
      }
    
    }.resume()
    
  }
}


extension String{
  var placeholder : UIImage{
    return UIImage(named: self)!
  }
}
