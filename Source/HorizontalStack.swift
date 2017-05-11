//
//  HorizontalStack.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 11/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public struct HorizontalStack: Node, Equatable {
    
    public let uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public var children = [IsNode]()
    public let props: HorizontalStackProps
    public let layout: Layout
    let ref: UnsafeMutablePointer<UIStackView>?
    
    public init(_ layout:Layout? = nil,
                ref: UnsafeMutablePointer<UIStackView>? = nil,
                _ children: [IsNode]) {
        var p = HorizontalStackProps()
//        p.text = text
        self.props = p
        self.layout = layout == nil ? Layout() : layout!
        self.ref = ref
        self.children = children
    }

}

public func == (lhs: HorizontalStack, rhs: HorizontalStack) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

public struct HorizontalStackProps: Equatable, Hashable {
    
    public var hashValue: Int {
        return 0
    }
}

public func == (lhs: HorizontalStackProps, rhs: HorizontalStackProps) -> Bool {
    return true
}
