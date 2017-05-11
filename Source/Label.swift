//
//  Label.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 11/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public struct Label: Node, Equatable {
    
    public let uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public var children = [IsNode]()
    let props: LabelProps
    public let layout: Layout
    public let ref: UnsafeMutablePointer<UILabel>?
    
    public init(_ text: String = "",
         _ layout:Layout? = nil,
         ref: UnsafeMutablePointer<UILabel>? = nil) {
        var p = LabelProps()
        p.text = text
        self.props = p
        self.layout = layout == nil ? Layout() : layout!
        self.ref = ref
    }
}

public func == (lhs: Label, rhs: Label) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

struct LabelProps: Equatable, Hashable {
    var text = ""
    
    var hashValue: Int {
        return text.hashValue
    }
}

func == (lhs: LabelProps, rhs: LabelProps) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
