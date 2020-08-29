//
//  ManagerConnnection.swift
//  MVVM-MoviesApp
//
//  Created by Victor Hugo Benitez Bosques on 27/08/20.
//  Copyright © 2020 Victor Hugo Benitez Bosques. All rights reserved.
//

import Foundation
import RxSwift
class ManagerConnection {
  
  func getPopularMovies() -> Observable<[Movie]> {
    
    return Observable.create { observer in
      
      guard let url = URL(string: Constant.URL.main+Constant.Endpoints.urlPopularMovies+Constant.apiKey) else {fatalError("URL Error") }
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      
      let session = URLSession.shared
      
      session.dataTask(with: request) { data, response , error in
        
        guard let data = data, let response = response as? HTTPURLResponse, error == nil, response.statusCode == 200 else {return }
        
        do{
          let arrData = try JSONDecoder().decode(Movies.self, from: data)
          observer.onNext(arrData.arrMovies)
        }catch let error{
          observer.onError(error)
          print("Operation error ", error)
        }
        
        observer.onCompleted()
      }.resume()
      
      return Disposables.create{
        session.finishTasksAndInvalidate()
      }
    }
    
  }
  
  
  // get Datail Movies
  
  func getDetailMovies(){
    
  }
  
}

