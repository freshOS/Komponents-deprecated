//
//  VerticalStack.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 11/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public struct VerticalStack: Node, Equatable {
    
    public var uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public var children = [IsNode]()
    public var props: StackProps
    public var layout: Layout
    let ref: UnsafeMutablePointer<UIStackView>?
    
    public init(props:((inout StackProps) -> Void)? = nil,
                layout: Layout? = nil,
                ref: UnsafeMutablePointer<UIStackView>? = nil,
                _ children: [IsNode]) {
        
        // Props
        let defaultProps = StackProps()
        if let p = props {
            var prop = defaultProps
            p(&prop)
            self.props = prop
        } else {
            self.props = defaultProps
        }
        
        self.layout = layout ?? Layout()
        self.ref = ref
        self.children = children
    }
}

public func == (lhs: VerticalStack, rhs: VerticalStack) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

public struct StackProps: Equatable, Hashable {
    
    public var spacing: CGFloat = 0
    
    public var hashValue: Int {
        return spacing.hashValue
    }
}

public func == (lhs: StackProps, rhs: StackProps) -> Bool {
    return lhs.spacing == rhs.spacing
}
