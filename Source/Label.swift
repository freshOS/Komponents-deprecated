//
//  Label.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 11/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public struct Label: Node, Equatable {
    
    public var uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public var children = [IsNode]()
    let props: LabelProps
    public var layout: Layout
    public let ref: UnsafeMutablePointer<UILabel>?
    
    public init(_ text: String = "",
                props: ((inout LabelProps) -> Void)? = nil,
                layout: Layout? = nil,
                ref: UnsafeMutablePointer<UILabel>? = nil) {
        var prop = LabelProps()
        prop.text = text
        if let p = props {
            p(&prop)
        }
        self.props = prop
        self.layout = layout ?? Layout()
        self.ref = ref
    }
}

public func == (lhs: Label, rhs: Label) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

public struct LabelProps: Equatable, Hashable {
    public var text = ""
    public var textColor =  UIColor.black
    public var font: UIFont?
    public var numberOfLines = 1
    public var textAlignment = NSTextAlignment.left
    
    public var hashValue: Int {
        return text.hashValue
            ^ textColor.hashValue
        ^ hashFor(font)
        ^ numberOfLines.hashValue
        ^ textAlignment.hashValue
    }
}

public func == (lhs: LabelProps, rhs: LabelProps) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
