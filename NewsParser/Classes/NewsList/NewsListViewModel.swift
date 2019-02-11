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
    
    init() {
        
    }
}
