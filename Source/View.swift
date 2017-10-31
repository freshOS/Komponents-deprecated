//
//  View.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 11/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public struct View: Node, Equatable {
    
    public var uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public var children = [IsNode]()
    public let props: ViewProps
    public var layout: Layout
    public var ref: UnsafeMutablePointer<UIView>?
    
    public init(
        color: UIColor? = nil,
        props:((inout ViewProps) -> Void)? = nil,
        layout: Layout? = nil,
        ref: UnsafeMutablePointer<UIView>? = nil,
        _ children: [IsNode]) {
        
        var prop = ViewProps()
        if let color = color {
            prop.backgroundColor = color
        }
        if let p = props {
            p(&prop)
        }
        self.props = prop
        
        self.layout = layout ?? Layout()
        self.ref = ref
        self.children = children
    }
    
    // No children init
    public init(
        color: UIColor? = nil,
        props: ((inout ViewProps) -> Void)? = nil,
        layout: Layout? = nil,
        ref: UnsafeMutablePointer<UIView>? = nil) {
        
        var prop = ViewProps()
        if let color = color {
            prop.backgroundColor = color
        }
        if let p = props {
            p(&prop)
        }
        self.props = prop
        
        self.layout = layout ?? Layout()
        self.ref = ref
        self.children = [IsNode]()
    }
}

public func == (lhs: View, rhs: View) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

public protocol HasViewProps {
    var backgroundColor: UIColor { get }
    var borderColor: UIColor { get }
    var borderWidth: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var isHidden: Bool { get }
    var alpha: CGFloat { get }
    var clipsToBounds: Bool { get }
    var isUserInteractionEnabled: Bool { get }
}

extension HasViewProps {
    var viewPropsHash: Int {
        return backgroundColor.hashValue
        ^ borderColor.hashValue
        ^ borderWidth.hashValue
        ^ cornerRadius.hashValue
        ^ isHidden.hashValue
        ^ alpha.hashValue
        ^ clipsToBounds.hashValue
        ^ isUserInteractionEnabled.hashValue
    }
}


public struct ViewProps: HasViewProps, Equatable, Hashable {
    
    // HasViewProps
    public var backgroundColor = UIColor.white
    public var borderColor = UIColor.clear
    public var borderWidth: CGFloat = 0
    public var cornerRadius: CGFloat = 0
    public var isHidden = false
    public var alpha: CGFloat = 1
    public var clipsToBounds = false
    public var isUserInteractionEnabled = true
    
    public var anchorPoint = CGPoint(x: 0.5, y: 0.5)

    public var hashValue: Int {
        return viewPropsHash
            ^ anchorPoint.x.hashValue
            ^ anchorPoint.y.hashValue
    }
}

public func == (lhs: ViewProps, rhs: ViewProps) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

public func hashFor<T: Hashable>(_ obj: T?) -> Int {
    if let t = obj {
        return t.hashValue
    }
    return 0
}
