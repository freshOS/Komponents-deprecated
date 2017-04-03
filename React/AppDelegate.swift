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
        
//        // Classic RootVC Setup
//        window = UIWindow(frame: UIScreen.main.bounds)
//        let vc = UIViewController()
//        window?.rootViewController = vc
//        window?.makeKeyAndVisible()
//        
//        // Load our component
//        let engine = WeactEngine()
//        engine.render(component: PhotoComponent(), in:vc.view)
        
        //window?.rootViewController = WeactViewController(component: PhotoComponent())
        
        
        
        // Classic RootVC Setup
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LoginScreen()
        window?.makeKeyAndVisible()
        return true
    }
}





// Helper to wrap componenet in a VC and thus use Components as VC-like object
// that we can present and push.
class WeactViewController<C:Component>: UIViewController {
    
    internal var component:C!
    
    init(component:C) {
        super.init(nibName: nil, bundle: nil)
        self.component = component
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        let engine = WeactEngine()
        engine.render(component: component, in: view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
