//
//  AppDelegate.swift
//  React
//
//  Created by Sacha Durand Saint Omer on 29/03/2017.
//  Copyright © 2017 Freshos. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Classic RootVC Setup
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        // Load our component
        let engine = WeactEngine()
        engine.render(component: ActionsBar(), in:vc.view)
        return true
    }
}
