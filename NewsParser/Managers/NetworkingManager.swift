//
//  NetworkingManager.swift
//  NewsParser
//
//  Created by Ильяс Ихсанов on 10/02/2019.
//  Copyright © 2019 ilyas. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum ServiceError: Error {
    case cannotParse
}

class NetworkingManager {
    
    private let session: URLSession
    private let apiKey = "7a2f0a2b013243738088357180fd1dd9"
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func getNewsList() -> Observable<[NewsJSON]> {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=7a2f0a2b013243738088357180fd1dd9")!
        return session.rx
            .json(url: url)
            .flatMap({ (json) -> Observable<[NewsJSON]> in
                guard
                    let json = json as? [String:Any],
                    let itemsJSON = json["articles"] as? [[String: Any]]
                else { return Observable.error(ServiceError.cannotParse) }
              let news = itemsJSON.compactMap({ (dict) -> NewsJSON in
                return NewsJSON.init(from: dict)!
              })
              return Observable.just(news)
            })
    }
}

struct NewsJSON {
    let title: String
    let declaration: String
    let url: String
}

extension NewsJSON {
    init?(from json: [String: Any]) {
        guard
            let title = json["title"] as? String,
            let description = json["description"] as? String,
            let url = json["url"] as? String
            else { return nil }
        self.init(title: title, declaration: description, url: url)
    }
}
