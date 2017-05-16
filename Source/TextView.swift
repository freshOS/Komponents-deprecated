//
//  TextView.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 13/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public struct TextView: Node, Equatable {
    
    public var uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public var children = [IsNode]()
    let props: TextViewProps
    public var layout: Layout
    public let ref: UnsafeMutablePointer<UITextView>?
    var registerTextChanged: ((UITextView) -> Void)?
    
    public init(text: String = "",
                textChanged: ((String) -> Void)? = nil,
                props:((inout TextViewProps) -> Void)? = nil,
                layout: Layout? = nil,
                ref: UnsafeMutablePointer<UITextView>? = nil) {
        var defaultProps = TextViewProps()
        defaultProps.text = text
        if let p = props {
            var prop = defaultProps
            p(&prop)
            self.props = prop
        } else {
            self.props = defaultProps
        }
        
        self.layout = layout ?? Layout()
        self.ref = ref
        
        registerTextChanged = { field in
            if let field = field as? BlockBasedUITextView, let textChanged = textChanged {
                field.setCallback(textChanged)
            }
        }
    }
}

public func == (lhs: TextView, rhs: TextView) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

public struct TextViewProps: Equatable, Hashable {
    
    public var backgroundColor = UIColor.clear
    public var text: String = ""
    
    public var hashValue: Int {
        return text.hashValue ^ backgroundColor.hashValue
    }
}

public func == (lhs: TextViewProps, rhs: TextViewProps) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
