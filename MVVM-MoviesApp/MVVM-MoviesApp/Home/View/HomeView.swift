//
//  HomeView.swift
//  MVVM-MoviesApp
//
//  Created by Victor Hugo Benitez Bosques on 8/27/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit
import RxSwift
class HomeView : UIViewController {
  
  @IBOutlet weak var tblView : UITableView!
  @IBOutlet weak var actActivity : UIActivityIndicatorView!
  
//  @IBOutlet weak var tblView: UITableView!
  private var router : HomeRouter = HomeRouter()
  private var viewModel : HomeViewModel = HomeViewModel()
  private var disposeBag = DisposeBag()
  private var arrMovies = [Movie]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.bind(view: self, router: router)
    getData()
    
    
  }
  
  private func getData(){
    return viewModel.getListMovieData()
      //Manage the concurrency of threand
      .subscribeOn(MainScheduler.instance)
      .observeOn(MainScheduler.instance)
      //observable susbcription
      .subscribe(onNext: { arrMovie in
        self.arrMovies = arrMovie
        self.reloadTableView()
      }, onError: { error in
        print(error.localizedDescription)
      }, onCompleted: {
      }).disposed(by: disposeBag)
  }
  
  func reloadTableView(){
    DispatchQueue.main.async {
//      self.actActivity.stopAnimating()
//      self.actActivity.isHidden = true
      self.tblView.reloadData()
    }
    
  }
  
  override init(nibName nibNameOrNil: String? = HomeView.identifier,
                bundle nibBundleOrNil: Bundle? = nil) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    return UITableViewCell()
  }
  
  
  
}

