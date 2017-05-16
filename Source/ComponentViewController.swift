//
//  ComponentViewController.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 26/04/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

open class ComponentViewController: UIViewController, Component {
    
    public var reactEngine: KomponentsEngine?
    public var state = true
    
    open func render() -> Tree {
        return View([])
    }
    
    override open func loadView() {
        view = UIView()
        KomponentsEngine().render(component:self, in: view)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("INJECTION_BUNDLE_NOTIFICATION"),
                         object: nil, queue: nil) {_ in
                self.view = UIView()
                KomponentsEngine().render(component:self, in: self.view)
            }
    }
    
    public func didRender() { }
}
