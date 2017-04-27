//
//  ComponentViewController.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 26/04/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit

class ComponentViewController: UIViewController, Component {
    var state = true
    
    func render() -> Node {
        return View([])
    }
    
    let engine = WeactEngine()
    
    override func loadView() {
        view = UIView()
        engine.render(component:self, in: view)
    }
    
    override func viewDidLoad() {
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
    
    func didRender() { }
}
