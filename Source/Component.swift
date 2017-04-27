//
//  Component.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 31/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import Foundation
import UIKit

public protocol Component:class, Renderable {
    associatedtype State
    var state: State { get set }
    func updateState(_ block:(inout State) -> Void)
}

public extension Component {
    func updateState(_ block:(inout State) -> Void) {
        block(&state)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"WeactStateChanged"), object: self)
    }
}


public extension Component where Self: UIViewController {
    func loadComponent() {
        view = UIView()
        let engine = WeactEngine()
        engine.render(component:self, in: view)
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil, queue: nil) {_ in
                engine.render(component:self, in: self.view)
        }
    }
}

public extension Component where Self: UIView {
    func loadComponent() {
        let engine = WeactEngine()
        engine.render(component:self, in: self)
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil, queue: nil) {_ in
                engine.render(component:self, in: self)
        }
    }
}
