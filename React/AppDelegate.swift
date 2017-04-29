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
import Weact

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LoadingVC() // Using a UIViewController Component.
        window?.makeKeyAndVisible()
        return true
    }
}

// Other ways to display components:

//        // Using View Controller wrapper.
//        window?.rootViewController = ComponentVC(component: TestLoop())

//        // Using UIView wrapper.
//        let vc = UIViewController()
//        window?.rootViewController = vc
//        let loginView = ComponentView(component: LoginComponent())
//        loginView.frame = vc.view.frame
//        vc.view.addSubview(loginView)

//        // Using bare Weact engine.
//        let vc = UIViewController()
//        window?.rootViewController = vc
//        let engine = WeactEngine()
//        engine.render(component: LoginComponent(), in:vc.view)
