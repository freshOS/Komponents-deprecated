//
//  ActivityIndicatorView.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 11/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

// TODO all refs make sure
import Foundation

public struct ActivityIndicatorView: Node, Equatable {
    
    public var uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public var children = [IsNode]()
    let props: ActivityIndicatorViewProps
    public var layout: Layout
    let ref: UnsafeMutablePointer<UIActivityIndicatorView>?
    
    public init(_ activityIndicatorStyle: UIActivityIndicatorViewStyle = .white,
                props:((inout ActivityIndicatorViewProps) -> Void)? = nil,
                layout: Layout? = nil,
                ref: UnsafeMutablePointer<UIActivityIndicatorView>? = nil) {
        var p = ActivityIndicatorViewProps()
        p.activityIndicatorStyle = activityIndicatorStyle
        props?(&p)
        self.props = p
        self.layout = layout ?? Layout()
        self.ref = ref
    }
}

public func == (lhs: ActivityIndicatorView, rhs: ActivityIndicatorView) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

public struct ActivityIndicatorViewProps: Equatable, Hashable {
    var activityIndicatorStyle = UIActivityIndicatorViewStyle.white
    public var isHidden = false
    public var hashValue: Int {
        return activityIndicatorStyle.rawValue
            ^ isHidden.hashValue
    }
}

public func == (lhs: ActivityIndicatorViewProps, rhs: ActivityIndicatorViewProps) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
