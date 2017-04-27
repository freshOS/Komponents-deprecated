//
//  ComponentVC.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 26/04/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit

/// Helper to render a given compoenent in a UIViewController.
/// By using this wrapper, you can use components incrementally by migrating
/// your UIViewControllers subclasses in your App.

class ComponentVC<T: Component>: UIViewController {
    
    let component: T!
    
    init(component: T) {
        self.component = component
        super.init(nibName: nil, bundle: nil)
    }
    
    var componentsView: ComponentView<T>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil, queue: nil) {_ in
                self.componentsView = ComponentView(component: self.component)
                self.view = self.componentsView
            }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        componentsView = ComponentView(component: component)
        view = componentsView
    }
}
