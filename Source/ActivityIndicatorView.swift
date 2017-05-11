//
//  ActivityIndicatorView.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 11/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

// TODO all refs make sure
import Foundation


//
//    var ref: UnsafeMutablePointer<UIActivityIndicatorView>?
//    var activityIndicatorStyle = UIActivityIndicatorViewStyle.gray
//
//    public init(_ activityIndicatorStyle: UIActivityIndicatorViewStyle = .gray,
//        self.activityIndicatorStyle = activityIndicatorStyle
//    }
//}

public struct ActivityIndicatorView: Node, Equatable {
    
    public let uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public var children = [IsNode]()
    let props: ActivityIndicatorViewProps
    public let layout: Layout
    var ref: UnsafeMutablePointer<UIActivityIndicatorView>?
    
    public init(_ activityIndicatorStyle:UIActivityIndicatorViewStyle = .white,
        _ layout:Layout? = nil,
                ref: UnsafeMutablePointer<UIActivityIndicatorView>? = nil) {
        var p = ActivityIndicatorViewProps()
        p.activityIndicatorStyle = activityIndicatorStyle
        self.props = p
        self.layout = layout == nil ? Layout() : layout!
    }
}

public func == (lhs: ActivityIndicatorView, rhs: ActivityIndicatorView) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

struct ActivityIndicatorViewProps: Equatable, Hashable {
    var activityIndicatorStyle = UIActivityIndicatorViewStyle.white
    var hashValue: Int {
        return activityIndicatorStyle.rawValue
    }
}

func == (lhs: ActivityIndicatorViewProps, rhs: ActivityIndicatorViewProps) -> Bool {
    return lhs.activityIndicatorStyle == rhs.activityIndicatorStyle
}
