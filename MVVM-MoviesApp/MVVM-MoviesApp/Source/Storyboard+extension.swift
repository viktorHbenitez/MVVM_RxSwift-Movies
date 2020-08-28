//
//  Storyboard+extension.swift
//  MVVM-MoviesApp
//
//  Created by Victor Hugo Benitez Bosques on 28/08/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit
protocol StoryboadID {static var identifier : String {get}}

extension StoryboadID where Self : UIViewController{
  static var identifier : String{
    return String(describing: self)
  }
}
extension UIViewController : StoryboadID{}
