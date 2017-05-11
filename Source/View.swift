//
//  View.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 11/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public struct View: Node, Equatable {
    
    public let uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public var children = [IsNode]()
    public let props: ViewProps
    public let layout: Layout
    public var ref: UnsafeMutablePointer<UIView>?
    
    // todo add props.
    public init(
        props:((inout ViewProps) -> Void)? = nil,
        layout: Layout? = nil,
         ref: UnsafeMutablePointer<UIView>? = nil,
         _ children: [IsNode]) {
        
        if let p = props {
            var prop = ViewProps()
            p(&prop)
            self.props = prop
        } else {
            self.props = ViewProps()
        }
        
        
        
        self.layout = layout == nil ? Layout() : layout!
        self.ref = ref
        self.children = children
    }
}

public func == (lhs: View, rhs: View) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

public struct ViewProps: Equatable, Hashable {
    
    public var backgroundColor = UIColor.white
    
    public var hashValue: Int {
        return backgroundColor.hashValue
    }
}

public func == (lhs: ViewProps, rhs: ViewProps) -> Bool {
    return true
}

