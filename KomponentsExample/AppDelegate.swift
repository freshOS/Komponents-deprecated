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
import Komponents

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = HelloPropsVC(name: "Chuck!")//UINavigationController(rootViewController: NavigationVC()) // Using a UIViewController Component.
        window?.makeKeyAndVisible()
        Komponents.logsEnabled = true
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

//        // Using bare Komponents engine.
//        let vc = UIViewController()
//        window?.rootViewController = vc
//        let engine = KomponentsEngine()
//        engine.render(component: LoginComponent(), in:vc.view)
