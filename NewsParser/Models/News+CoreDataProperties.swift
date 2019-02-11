//
//  News+CoreDataProperties.swift
//  NewsParser
//
//  Created by Ильяс Ихсанов on 09/02/2019.
//  Copyright © 2019 ilyas. All rights reserved.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var title: String?
    @NSManaged public var declaration: String?
    @NSManaged public var url: String!

}

extension News {
    init?(from json: [String: Any]) {
        guard
            let jsonTitle = json["title"] as? String,
            let jsonDescription = json["description"] as? String
            let jsonURL = json["url"] as? String
        else { return nil }
        
    }
}
