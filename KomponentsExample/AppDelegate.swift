//
//  AppDelegate.swift
//  React
//
//  Created by Sacha Durand Saint Omer on 29/03/2017.
//  Copyright © 2017 Freshos. All rights reserved.
//

import UIKit
import Komponents

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection10.bundle")?.load()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navVC = UINavigationController(rootViewController: NavigationVC())
        navVC.navigationBar.isTranslucent = false
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        Komponents.logsEnabled = true
        return true
    }
}
