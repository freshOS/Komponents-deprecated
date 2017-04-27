//
//  AppDelegate.swift
//  React
//
//  Created by Sacha Durand Saint Omer on 29/03/2017.
//  Copyright © 2017 Freshos. All rights reserved.
//

// TODO stateless component ?
// TODO ViewLayout with spacies and margins in the childrne's aray ??

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        // Using View Controller wrapper.
        window?.rootViewController = ComponentVC(component: LoginComponent())
        
        // Using UIView wrapper.
//        let vc = UIViewController()
//        window?.rootViewController = vc
//        let loginView = ComponentView(component: LoginComponent())
//        loginView.frame = vc.view.frame
//        vc.view.addSubview(loginView)
        
        // Using bare Weact engine.
//        let vc = UIViewController()
//        window?.rootViewController = vc
//        let engine = WeactEngine()
//        engine.render(component: LoginComponent(), in:vc.view)
        
        // Tell Weact engine to re-render when we inject code through injection4Xcode plugin.
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name(rawValue:"INJECTION_BUNDLE_NOTIFICATION"),
                                               object: nil,
                                               queue: nil) { _ in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"WeactStateChanged"), object: nil)
            }
        
        window?.makeKeyAndVisible()
        return true
    }
}
