//
//  DetailMoviewView.swift
//  MVVM-MoviesApp
//
//  Created by Victor Hugo Benitez Bosques on 30/08/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit
import RxSwift

class DetailMoviewView: UIViewController {
  
  @IBOutlet private weak var imgMovie : UIImageView!
  @IBOutlet private weak var lblTitle : lblCell!
  @IBOutlet private weak var lblDescription : lblCell!
  
  
  var strMovieID : String?
  var rtRouter : DetailRouter = DetailRouter()
  var viewModel : DetailViewModel = DetailViewModel()
  var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.bind(self, router: rtRouter)
    getDataFromManagerConnection()
  }
  
  override init(nibName nibNameOrNil: String? = DetailMoviewView.identifier,
                bundle nibBundleOrNil: Bundle? = nil) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func getDataFromManagerConnection(){
    return viewModel.getListMoviewData(strMovieID: strMovieID)
      //observable susbcription
      .subscribe(onNext: { bsDetailMovie in
        self.setupView(bsDetailMovie)
      }, onError: { error in
        print(error.localizedDescription)
      }, onCompleted: {
      }).disposed(by: disposeBag)
  }
  
  func setupView( _ bsData : DetailMovie){
    DispatchQueue.main.async {
      self.lblTitle.text = bsData.strTitle
      self.lblDescription.text = bsData.strDescription
      self.imgMovie.imageFromServerURL(from: bsData.strUrl)
    }
  }
  
}
