//
//  AppDelegate.swift
//  React
//
//  Created by Sacha Durand Saint Omer on 29/03/2017.
//  Copyright © 2017 Freshos. All rights reserved.
//


//TODO
// 1 - Use syntax Without React, just to create static view hierachies.
// 1 bis use in a render block but renered only once then poke at views.
// 2 - Use in parallel with a react engine.
// 3 Both independent of the layout system, can use native autolayout or other (Stevia?)

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        //window?.rootViewController = WeactViewController(component: PhotoComponent())
        
        // Classic RootVC Setup
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        window?.rootViewController = vc
        
        let engine = WeactEngine()
        engine.render(component: LoginComponent(), in:vc.view)
        
//        window?.rootViewController = LoginComponent()
        window?.makeKeyAndVisible()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"INJECTION_BUNDLE_NOTIFICATION"), object: nil, queue: nil) { n in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"WeactStateChanged"), object: nil)
        }
        
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
