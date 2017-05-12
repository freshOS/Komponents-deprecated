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

public protocol IsComponent:class, Renderable {
    var uniqueIdentifier:String { get }
    func didRender()
    func enablePatching() -> Bool
    func willDeinitComponent()
}

public extension IsComponent {
    public var uniqueIdentifier: String {
        return "\(ObjectIdentifier(self).hashValue)"
    }
}

public protocol StatelessComponent: IsComponent { }

public protocol Component: IsComponent, HasState, IsNode { }

extension Component { // COmponene is a node
    public var layout: Layout { return Layout() }
    public var children: [IsNode] { return [] }
    public var propsHash: Int { return 0 }
    public var uniqueIdentifier: Int { return 0}
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
}

public extension Component {
    func updateState(_ block:(inout State) -> Void) {
        if Komponents.logsEnabled {
            print("☝️ Update State : \(self)")
        }
        block(&state)
        askForRefresh(patching: true)
    }
}

public extension IsComponent where Self: UIViewController {
    func loadComponent() {
//        view = KomponentsEngine.shared.render(component: self)
        view = UIView()
        view.backgroundColor = .white
        let engine = KomponentsEngine()
        engine.render(component: self, in: view)
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil, queue: nil) { [weak self] _ in
                if let weakSelf = self {
                    weakSelf.askForRefresh(patching: false) // Patching crashes with injection
                }
        }
    }
}

public extension IsComponent where Self: UIView {
    func loadComponent() {
        KomponentsEngine.shared.render(component: self, in: self)
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil, queue: nil) { [weak self] _ in
                if let weakSelf = self {
                    weakSelf.askForRefresh(patching: false) // Patching crashes with injection
                }
        }
    }
}

public extension IsComponent where Self: UITableViewCell {
    func loadComponent() {
        KomponentsEngine.shared.render(component: self, in: self.contentView)
//        NotificationCenter.default
//            .addObserver(forName: NSNotification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil, queue: nil) { [weak self] _ in
//                if let weakSelf = self {
//                    weakSelf.askForRefresh()
//                }
//        }
    }
}


public extension IsComponent {
    func askForRefresh(patching: Bool) {
        KomponentsEngine.shared.updateComponent(self, patching: patching)
    }
}

public extension IsComponent where Self: UIViewController {
    func askForRefresh(patching: Bool) {
        KomponentsEngine.shared.render(component: self, in: view)
    }
}

//public protocol CanBeDirty {
//    var isDirty: Bool { get set }
//}
//
//public protocol HasEquatableProps {
//    associatedtype Props:Equatable
//    var props: Props { get set }
//}
//
//extension HasEquatableProps where Self: CanBeDirty {
//    
//    public mutating func updateProps(newProps: Props) {
//        if newProps != props {
//            props = newProps
//            isDirty = true
//        }
//    }
//}
//
//public protocol CellComponent: IsComponent, HasEquatableProps, CanBeDirty {
//    
//}

//public extension CellComponent {
//    
//    func refresh() {
//        KomponentsEngine.shared.updateComponent(self, patching: false)
//    }
//}

public extension IsComponent {
    func enablePatching() -> Bool {
        return false
    }
}


public extension IsComponent {
    func willDeinitComponent() {
        // Find and Remove children components references that retain sub-components.
//        if let childComponentsIds = KomponentsEngine.shared.componentsChildren[uniqueIdentifier] {
//            for id in childComponentsIds {
//                KomponentsEngine.shared.componentsMap.removeValue(forKey: id)
//            }
//        }
//        KomponentsEngine.shared.componentsChildren.removeValue(forKey: uniqueIdentifier)
    }
}
