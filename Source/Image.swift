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
                props: ((inout ImageProps) -> Void)? = nil,
                layout: Layout? = nil,
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
        self.layout = layout ?? Layout()
        self.ref = ref
    }
}

public func == (lhs: Image, rhs: Image) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

public struct ImageProps: HasViewProps, Equatable, Hashable {
    
    // HasViewProps
    public var backgroundColor = UIColor.white
    public var borderColor = UIColor.clear
    public var borderWidth: CGFloat = 0
    public var cornerRadius: CGFloat = 0
    public var isHidden = false
    public var alpha: CGFloat = 1
    public var clipsToBounds = false
    public var isUserInteractionEnabled = true
    
    public var image = UIImage()
    public var contentMode = UIView.ContentMode.scaleToFill
    
    public var hashValue: Int {
        return viewPropsHash
            ^ image.hashValue
            ^ contentMode.hashValue
    }
}

public func == (lhs: ImageProps, rhs: ImageProps) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
