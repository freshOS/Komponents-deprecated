//
//  Progress.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 12/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public struct Progress: Node, Equatable {
    
    public var uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public var children = [IsNode]()
    let props: ProgressProps
    public var layout: Layout
    public let ref: UnsafeMutablePointer<UIProgressView>?
    
    public init(
        _ progress: Float = 0,
        changed: ((Bool) -> Void)? = nil,
        props:((inout ProgressProps) -> Void)? = nil,
        _ layout: Layout? = nil,
        ref: UnsafeMutablePointer<UIProgressView>? = nil) {
        var defaultProps = ProgressProps()
        defaultProps.progress = progress
        if let p = props {
            var prop = defaultProps
            p(&prop)
            self.props = prop
        } else {
            self.props = defaultProps
        }
        self.layout = layout ?? Layout()
        self.ref = ref
    }
}

public func == (lhs: Progress, rhs: Progress) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

public struct ProgressProps: Equatable, Hashable {
    
    public var progress: Float = 0
    
    public var hashValue: Int {
        return progress.hashValue
    }
}

public func == (lhs: ProgressProps, rhs: ProgressProps) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
