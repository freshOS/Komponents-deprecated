//
//  Node.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public typealias Tree = IsNode

public protocol HasLayout {
    var layout: Layout { get }
}

public protocol HasChildren {
    var children: [IsNode] { get }
}

protocol HasProps {
    associatedtype Props: Equatable
    var props: Props { get }
}

public protocol HasAPropsHash {
    var propsHash: Int { get }
}

public protocol HasAUniqueIdentifier {
    var uniqueIdentifier: Int { get }
}

public protocol HasState: class {
    associatedtype State
    var state: State { get set }
    func updateState(_ block:(inout State) -> Void)
}

public protocol IsNode: HasLayout, HasChildren, HasAPropsHash, HasAUniqueIdentifier { }

protocol Node: IsNode, HasProps { }

public protocol Renderable {
    func render() -> Tree
}

// MARK: - Components

public protocol IsComponent: Renderable, IsNode {
    func didRender()
    func didUpdateState()
    func forceRerender() -> Bool
}

// MARK: - Stateless

public protocol StatelessComponent: IsComponent { }

// MARK: - Statefull

public protocol IsStatefulComponent: class, IsComponent {
    var uniqueComponentIdentifier: String { get }
    var reactEngine: KomponentsEngine? { get set }
}

public protocol Component: IsStatefulComponent, HasState { }
