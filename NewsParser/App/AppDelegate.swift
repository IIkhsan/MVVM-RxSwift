//
//  AppDelegate.swift
//  NewsParser
//
//  Created by Ильяс Ихсанов on 09/02/2019.
//  Copyright © 2019 ilyas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        CoreDataStack.sharedInstance.applicationDocumentsDirectory()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataStack.sharedInstance.saveContext()
    }

}

