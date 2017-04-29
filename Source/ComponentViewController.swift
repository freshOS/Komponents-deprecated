//
//  ComponentViewController.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 26/04/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

open class ComponentViewController: UIViewController, Component {
    public var state = true
    
    open func render() -> Node {
        return View([])
    }
    
    let engine = WeactEngine()
    
    override open func loadView() {
        view = UIView()
        engine.render(component:self, in: view)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("INJECTION_BUNDLE_NOTIFICATION"),
                         object: nil, queue: nil) {_ in
                self.view = UIView()
                self.engine.render(component:self, in: self.view)
                self.didRender()
            }
        didRender()
    }
    
    public func didRender() { }
}
