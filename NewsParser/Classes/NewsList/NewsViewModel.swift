//
//  NewsViewModel.swift
//  NewsParser
//
//  Created by Ильяс Ихсанов on 09/02/2019.
//  Copyright © 2019 ilyas. All rights reserved.
//

import Foundation

class NewsViewModel {
    let title: String
    let declaration: String
    let url: URL
    
    init(news: NewsJSON) {
        self.url = URL(string: news.url)!
        self.title = news.title
        self.declaration = news.declaration
    }
}
