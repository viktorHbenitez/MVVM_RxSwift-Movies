//
//  HomeCustomCell.swift
//  MVVM-MoviesApp
//
//  Created by Victor Hugo Benitez Bosques on 28/08/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

@IBDesignable
class lblCell: UILabel {
  enum styleEnum : Int{
    case title
    case content
  }
  
  @IBInspectable public var iType : Int = 0{
    didSet{
      self.styleLabel = styleEnum(rawValue: iType) ?? .content
      setupLabel()
    }
  }
  
  var styleLabel : styleEnum = .content
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func setupLabel(){
    switch styleLabel {
    case .title :
      self.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    case .content:
      self.font = UIFont.systemFont(ofSize: 17, weight: .regular)

    }
  }
  
}

class HomeCustomCell: UITableViewCell {
  
  @IBOutlet private weak var lblTitle : lblCell!
  @IBOutlet private weak var lblContentTitle : lblCell!
  @IBOutlet private weak var lblDescription : lblCell!
  @IBOutlet private weak var lblContentDescription : lblCell!
  @IBOutlet private weak var imgMovie : UIImageView!
  
  func setupCell(_ item : IItemInterface){
    lblContentTitle.text = item.strTitle
    lblContentDescription.text = item.strOverview
    imgMovie.imageFromServerURL(from: item.strUrl)
  }
  
}



/*:
 ## TITLE
 - - - - - - - - - -
 
 Concept: Description
 
 Something is executed in the process
 
 - **Bold**      : Description.
 
 
 qos : Quality of service (priority)
 - user interactive (highest)
 - User initated (second highest)
 - ...
 - background (lowest)
 
 Async (Asynchronous) - Your program does not wait for code to finish. it continues on.
 Sync (Synchronues) - Your program waits for code / task to finish before continuing to the next task
 
 ## SUBTITLE
 Concept : Description
 
 LINK Find more information [Description link](https://www.google.com)
 
 SHOW CODE
 
 ```Swift
 var strParameter : String?
 ```
 IMAGE
 ![image description](image.png)
 */
