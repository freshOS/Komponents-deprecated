//
//  Field.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 12/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public struct Field: Node, Equatable {
    
    public let uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public var children = [IsNode]()
    let props: FieldProps
    public let layout: Layout
    public let ref: UnsafeMutablePointer<UITextField>?
    var registerTextChanged: ((UITextField) -> Void)?
    
    public init(_ placeholder: String = "",
                text: String = "",
                textChanged: ((String) -> Void)? = nil,
                props:((inout FieldProps) -> Void)? = nil,
                layout:Layout? = nil,
                ref: UnsafeMutablePointer<UITextField>? = nil) {

        var defaultProps = FieldProps()
        defaultProps.placeholder = placeholder
        defaultProps.text = text
        if let p = props {
            var prop = defaultProps
            p(&prop)
            self.props = prop
        } else {
            self.props = defaultProps
        }
        
        self.layout = layout == nil ? Layout() : layout!
        self.ref = ref
        
        registerTextChanged = { field in
            if let field = field as? BlockBasedUITextField, let textChanged = textChanged {
                field.setCallback(textChanged)
            }
        }
    }
}

public func == (lhs: Field, rhs: Field) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

public struct FieldProps: Equatable, Hashable {
    
    public var placeholder: String = ""
    public var text: String = ""
    
    public var hashValue: Int {
        return placeholder.hashValue ^ text.hashValue
    }
}

public func == (lhs: FieldProps, rhs: FieldProps) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
