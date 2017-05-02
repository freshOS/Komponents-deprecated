//
//  Component.swift
//  Komponents
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
        print("☝️ COMPONENT TO UPDATE : \(self.uniqueIdentifier)")
        block(&state)
        askForRefresh()
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
        KomponentsEngine.shared.render(component: self, in: view)
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil, queue: nil) { [weak self] _ in
                if let weakSelf = self {
                    weakSelf.askForRefresh()
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
                    weakSelf.askForRefresh()
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
    func askForRefresh() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"KomponentsStateChanged"), object: self)
    }
}

public protocol CanBeDirty {
    var isDirty: Bool { get set }
}

public protocol HasEquatableProps {
    associatedtype Props:Equatable
    var props: Props { get set }
}

extension HasEquatableProps where Self: CanBeDirty {
    
    public mutating func updateProps(newProps: Props) {
        if newProps != props {
            props = newProps
            isDirty = true
        }
    }
}

public protocol CellComponent: IsComponent, HasEquatableProps, CanBeDirty {
    
}

public extension CellComponent {
    
    func refresh() {
        KomponentsEngine.shared.updateComponent(self)
    }
}
