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
    
    init(news: News) {
        self.url = URL(fileURLWithPath: news.url)
        if let title = news.title {
            self.title = title
        } else {
            self.title = "No title"
        }
        if let declaration = news.declaration {
            self.declaration = declaration
        } else {
            self.declaration = "No declaration"
        }
        
        
    }
}
