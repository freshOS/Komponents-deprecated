//
//  VerticalStack.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 11/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public struct VerticalStack: Node, Equatable {
    
    public let uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public var children = [IsNode]()
    public let props: VerticalStackProps
    public let layout: Layout
    let ref: UnsafeMutablePointer<UIStackView>?
    
    public init(_ layout:Layout? = nil,
                ref: UnsafeMutablePointer<UIStackView>? = nil,
                _ children: [IsNode]) {
        var p = VerticalStackProps()
        self.props = p
        self.layout = layout == nil ? Layout() : layout!
        self.ref = ref
        self.children = children
    }
}

public func == (lhs: VerticalStack, rhs: VerticalStack) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

public struct VerticalStackProps: Equatable, Hashable {
    
    public var hashValue: Int {
        return 0
    }
}

public func == (lhs: VerticalStackProps, rhs: VerticalStackProps) -> Bool {
    return true
}
