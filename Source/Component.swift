//
//  Component.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 31/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation
import UIKit

public protocol Renderable {
    func render() -> Tree
}

public protocol IsComponent: Renderable, IsNode {
    func didRender()
    func didUpdateState()
    func forceRerender() -> Bool
}

public protocol IsStatefulComponent: class, IsComponent {
    var uniqueComponentIdentifier: String { get }
    var reactEngine: KomponentsEngine? { get set }
}

public extension IsStatefulComponent {
    public var uniqueComponentIdentifier: String {
        return "\(ObjectIdentifier(self).hashValue)"
    }
}

public protocol StatelessComponent: IsComponent { }

public protocol Component: IsStatefulComponent, HasState { }

extension IsComponent { // COmponene is a node
    public var layout: Layout { return Layout() }
    public var children: [IsNode] { return [] }
    public var propsHash: Int { return 0 }
    public var uniqueIdentifier: Int { return 0 }
}

public protocol HasState: class {
    associatedtype State
    var state: State { get set }
    func updateState(_ block:(inout State) -> Void)
}

public extension IsComponent {
    
    func didRender() {
//        print("didRender \(self)")
    }
    
    func didUpdateState() {
        
    }
}

public extension Component {
    func updateState(_ block:(inout State) -> Void) {
        if Komponents.logsEnabled {
            print("☝️ Update State : \(self)")
        }
        block(&state)
        askForRefresh()
        didUpdateState()
    }
}

public extension IsStatefulComponent where Self: UIViewController {
    func loadComponent() {
        reactEngine = KomponentsEngine()
        view = UIView()
        view.backgroundColor = .white
        reactEngine?.render(component: self, in: view)
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("INJECTION_BUNDLE_NOTIFICATION"),
                         object: nil,
                         queue: nil) { [weak self] n in
                            if let weakSelf = self, notificationContains(notification: n, object: weakSelf) {
                                weakSelf.reactEngine?.render(component: weakSelf, in: weakSelf.view)
                            }
            }
    }
}

public extension IsStatefulComponent {
    public func supportInjection() {
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("INJECTION_BUNDLE_NOTIFICATION"),
                         object: nil,
                         queue: nil) { [weak self] n in
                            if let weakSelf = self, notificationContains(notification: n, object: weakSelf) {
                                weakSelf.reactEngine?.render(subComponent: weakSelf)
                            }
        }
    }
}


public extension StatelessComponent where Self: UIViewController {
    func loadComponent() {
        let engine = KomponentsEngine()
        view = UIView()
        view.backgroundColor = .white
        engine.render(component: self, in: view)
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("INJECTION_BUNDLE_NOTIFICATION"),
                         object: nil,
                         queue: nil) { [weak self] n in
                            if let weakSelf = self, notificationContains(notification: n, object: weakSelf) {
                                engine.render(component: weakSelf, in: weakSelf.view)
                            }
            }
    }
}

public func notificationContains(notification: Notification, object: Any ) -> Bool {
    if let arrayOfInjectedObjects = notification.object as? [Any] {
        for o in arrayOfInjectedObjects {
            let registeredClassName = String(describing: type(of: object))
            var injectedClassName = String(describing: o)
            let s = injectedClassName.characters.split(separator: ".").map(String.init)
            if let last = s.last {
                injectedClassName = last
            }
            if injectedClassName == registeredClassName {
                return true
            }
        }
    }
    return false
}

public extension StatelessComponent where Self: UIView {
    func loadComponent() {
        let engine = KomponentsEngine()
        engine.render(component: self, in: self)
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("INJECTION_BUNDLE_NOTIFICATION"),
                         object: nil,
                         queue: nil) { [weak self] _ in
                if let weakSelf = self {
//                    weakSelf.askForRefresh(patching: false) // Patching crashes with injection
                }
            }
    }
}

public extension IsStatefulComponent where Self: UIView {
    func loadComponent() {
        reactEngine = KomponentsEngine()
        reactEngine?.render(component: self, in: self)
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("INJECTION_BUNDLE_NOTIFICATION"),
                         object: nil,
                         queue: nil) { [weak self] _ in
                if let weakSelf = self {
                    //                    weakSelf.askForRefresh(patching: false) // Patching crashes with injection
                }
            }
    }
}

public extension IsStatefulComponent {
    
    func askForRefresh() {
        if let vc = self as? UIViewController {
            reactEngine?.render(component: self, in: vc.view)
        } else if let view = self as? UIView {
            reactEngine?.render(component: self, in: view)
        } else {
            reactEngine?.render(subComponent: self)
        }
    }
}

public extension IsComponent {

    func forceRerender() -> Bool {
        return false
    }
}
