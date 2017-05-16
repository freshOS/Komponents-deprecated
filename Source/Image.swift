//
//  Image.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 12/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public struct Image: Node, Equatable {
    
    public var uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public var children = [IsNode]()
    let props: ImageProps
    public var layout: Layout
    public let ref: UnsafeMutablePointer<UIImageView>?
    
    public init(_ image: UIImage = UIImage(),
                props:((inout ImageProps) -> Void)? = nil,
                layout:Layout? = nil,
                ref: UnsafeMutablePointer<UIImageView>? = nil) {
        var defaultProps = ImageProps()
        defaultProps.image = image
        if let p = props {
            var prop = defaultProps
            p(&prop)
            self.props = prop
        } else {
            self.props = defaultProps
        }
        self.layout = layout == nil ? Layout() : layout!
        self.ref = ref
    }
}

public func == (lhs: Image, rhs: Image) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

public struct ImageProps: Equatable, Hashable {
    
    public var image = UIImage()
    public var contentMode = UIViewContentMode.scaleToFill
    
    public var hashValue: Int {
        return image.hashValue
            ^ contentMode.hashValue
    }
}

public func == (lhs: ImageProps, rhs: ImageProps) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
