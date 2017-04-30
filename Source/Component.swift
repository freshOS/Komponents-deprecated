//
//  Component.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 31/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation
import UIKit

public protocol IsComponent:class, Renderable {
    var uniqueIdentifier:String { get }
    func didRender()
}

public extension IsComponent {
    public var uniqueIdentifier: String {
        return "\(ObjectIdentifier(self).hashValue)"
    }
}

public protocol StatelessComponent: IsComponent { }

public protocol Component: IsComponent, HasState { }

public protocol HasState: class {
    associatedtype State
    var state: State { get set }
    func updateState(_ block:(inout State) -> Void)
}

public extension IsComponent {
    
    func didRender() {
//        print("didRender \(self)")
    }
}

public extension Component {
    func updateState(_ block:(inout State) -> Void) {
        block(&state)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"WeactStateChanged"), object: self)
    }
}

class TestComp : IsComponent {
    func render() -> Node {
        return View([])
    }
}

public extension IsComponent where Self: UIViewController {
    func loadComponent() {
        view = UIView()
        WeactEngine.shared.render(component: self, in: view)
//        NotificationCenter.default
//            .addObserver(forName: NSNotification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil, queue: nil) { [weak engine] _ in
//                engine?.render(component:self, in: self.view)
//            }
    }
}

public extension IsComponent where Self: UIView {
    func loadComponent() {
        WeactEngine.shared.render(component: self, in: self)
        
//        NotificationCenter.default
//            .addObserver(forName: NSNotification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil, queue: nil) {_ in
//                engine.render(component:self, in: self)
//            }
    }
}
