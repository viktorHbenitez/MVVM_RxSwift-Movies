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
  
  @IBOutlet weak var tblView : UITableView!{
    didSet{
      tblView.delegate = self
      tblView.dataSource = self
    }
  }
  @IBOutlet weak var actActivity : UIActivityIndicatorView!
  
//  @IBOutlet weak var tblView: UITableView!
  private var router : HomeRouter = HomeRouter()
  private var viewModel : HomeViewModel = HomeViewModel()
  private var disposeBag = DisposeBag()
  private var arrMovies = [Movie]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.bind(view: self, router: router)
    setupTableView()
    getDataFromManagerConnection()
  }
  
  func setupTableView(){
    tblView.register(UINib(nibName: HomeCustomCell.identifier, bundle: nil),
                     forCellReuseIdentifier: HomeCustomCell.identifier)
    
  }
  // get data for API Service form ViewModel
  private func getDataFromManagerConnection(){
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
      }).disposed(by: disposeBag) // completed  rxObserve
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
    return arrMovies.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if let cell = tableView.dequeueReusableCell(withIdentifier: HomeCustomCell.identifier, for: indexPath) as? HomeCustomCell{
      cell.setupCell(arrMovies[indexPath.row])
      return cell
    }
    
    return UITableViewCell()
  }
  
  
  
}

