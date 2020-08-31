//
//  HomeView.swift
//  MVVM-MoviesApp
//
//  Created by Victor Hugo Benitez Bosques on 8/27/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class HomeView : UIViewController {
  
  @IBOutlet weak var tblView : UITableView!{
    didSet{
      tblView.delegate = self
      tblView.dataSource = self
    }
  }
  
  private var router : HomeRouter = HomeRouter()
  var viewModel : HomeViewModel = HomeViewModel()
  private var disposeBag = DisposeBag()
  private var arrMovies = [IItemInterface]()
  private var arrFiltered : [IItemInterface] = [IItemInterface]()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.bind(view: self, router: router)
    setupTableView()
    getDataFromManagerConnection()
    manageSearchbar()
  }
  
  
  lazy var searchController : UISearchController  = {
    let controller = UISearchController(searchResultsController: nil)
    controller.hidesNavigationBarDuringPresentation = true
    controller.obscuresBackgroundDuringPresentation = false
    controller.searchBar.sizeToFit()
    controller.searchBar.barStyle = .default
    controller.searchBar.backgroundColor = .none
    controller.searchBar.placeholder = "Buscar una pelicula"
    return controller
  }()
  
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
  
  func setupSearchbarController() -> UISearchController{
    let searchCont = searchController
    searchCont.searchBar.delegate = self
    searchCont.searchBar.frame = CGRect(x: searchCont.searchBar.frame.minX, y: searchCont.searchBar.frame.minY, width : navigationController?.navigationBar.frame.width ?? 0, height: searchCont.searchBar.frame.height)
    self.navigationItem.searchController = searchCont
    
    return searchCont
  }
  
  func manageSearchbar(){
   let searchCont = setupSearchbarController()
    // filter with rxSwift
    // update the model when the text is changed
    // create a observable
    searchCont.searchBar.rx.text
      .orEmpty
      .distinctUntilChanged()
      // subcribe to the observer
      .subscribe(onNext: { strResult in
        
        self.arrFiltered = self.arrMovies.filter({ bsmovie in
          self.reloadTableView()
          return bsmovie.strTitle.contains(strResult)
          
        })
      }).disposed(by: disposeBag)
    
  }
  
}

extension HomeView : UISearchBarDelegate{
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    
    searchController.isActive = false
    searchBar.resignFirstResponder()
    reloadTableView()
  }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchController.isActive && searchController.searchBar.text != ""{
      return arrFiltered.count
    }
    else{
      return arrMovies.count
    }

  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if let cell = tableView.dequeueReusableCell(withIdentifier: HomeCustomCell.identifier, for: indexPath) as? HomeCustomCell{
      
      if searchController.isActive && searchController.searchBar.text != ""{
        cell.setupCell(arrFiltered[indexPath.row])
      }else{
        cell.setupCell(arrMovies[indexPath.row])
      }
      return cell
    }
    
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView,
                 didSelectRowAt indexPath: IndexPath) {
    var bsData : IItemInterface?
    if searchController.isActive && searchController.searchBar.text != ""{
      bsData = arrFiltered[indexPath.row]
    }
    else{
      bsData = arrMovies[indexPath.row]
    }
    viewModel.makeDetailView(strMovieID: bsData?.strID)
  }
  
}

