//
//  NewsListViewModel.swift
//  NewsParser
//
//  Created by Ильяс Ихсанов on 09/02/2019.
//  Copyright © 2019 ilyas. All rights reserved.
//

import Foundation
import RxSwift

class NewsListViewModel {
    
    // MARK: - Inputs
    let selectedNews: AnyObserver<NewsViewModel>
    let reload: AnyObserver<Void>
    
    // MARK: - Outputes
    let news: Observable<[NewsViewModel]>
    let navigationTitle: Observable<String>
    let alertMessage: Observable<String>
    let showNews: Observable<URL>
    
    init(networkManager: NetworkingManager = NetworkingManager()) {
      
      let _reload = PublishSubject<Void>()
      self.reload = _reload.asObserver()
      
      self.navigationTitle = BehaviorSubject<String>(value: "Title").asObservable()
      
      let _alertMessage = PublishSubject<String>()
      self.alertMessage = _alertMessage.asObservable()
      
      self.news = _reload.asObserver()
        .flatMap({ () -> Observable<[NewsViewModel]> in
        networkManager.getNewsList()
          .catchError({ (error) -> Observable<[NewsJSON]> in
            _alertMessage.onNext(error.localizedDescription)
            return Observable.empty()
          })
          .map { news in news.map { news in return NewsViewModel.init(news: news) } }
      })
      
      let _selectedNews = PublishSubject<NewsViewModel>()
      self.selectedNews = _selectedNews.asObserver()
      self.showNews = _selectedNews.asObservable()
        .map { $0.url }
    }
}
