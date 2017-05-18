//
//  Scrollview.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 13/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public struct ScrollView: Node, Equatable {

    public var uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public var children = [IsNode]()
    public let props: ScrollViewProps
    public var layout: Layout
    public var ref: UnsafeMutablePointer<UIScrollView>?
    
    public init(
        props:((inout ScrollViewProps) -> Void)? = nil,
        layout: Layout? = nil,
        ref: UnsafeMutablePointer<UIScrollView>? = nil,
        _ children: [IsNode]) {
        
        if let p = props {
            var prop = ScrollViewProps()
            p(&prop)
            self.props = prop
        } else {
            self.props = ScrollViewProps()
        }
        
        self.layout = layout ?? Layout()
        self.ref = ref
        self.children = children
    }
    
    public init(
        props:((inout ScrollViewProps) -> Void)? = nil,
        layout: Layout? = nil,
        ref: UnsafeMutablePointer<UIScrollView>? = nil) {
        
        if let p = props {
            var prop = ScrollViewProps()
            p(&prop)
            self.props = prop
        } else {
            self.props = ScrollViewProps()
        }
        
        self.layout = layout ?? Layout()
        self.ref = ref
        self.children = [IsNode]()
    }
}

public func == (lhs: ScrollView, rhs: ScrollView) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

public struct ScrollViewProps: Equatable, Hashable {
    
    public var backgroundColor = UIColor.white
    public var borderColor = UIColor.clear
    public var borderWidth: CGFloat = 0
    public var cornerRadius: CGFloat = 0
    public var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    
    public var hashValue: Int {
        return backgroundColor.hashValue
            ^ borderColor.hashValue
            ^ borderWidth.hashValue
            ^ cornerRadius.hashValue
            ^ anchorPoint.x.hashValue
            ^ anchorPoint.y.hashValue
    }
}

public func == (lhs: ScrollViewProps, rhs: ScrollViewProps) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
