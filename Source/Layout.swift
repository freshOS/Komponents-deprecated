//
//  Layout.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 11/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public func top(_ value: Int) -> Layout {
    return Layout(top: value)
}

public var center: Layout {
    return Layout().centered()
}

public struct Layout: Equatable {
    
    public static func top(_ value: Int) -> Layout {
        return Layout(top: value)
    }
    
    public static var center: Layout {
        return Layout().centered()
    }
    
    public static var fill: Layout {
        return Layout().fill()
    }
    
    let top: Int?
    let right: Int?
    let bottom: Int?
    let left: Int?
    let width: Int?
    let height: Int?
    let isCenteredHorizontally: Bool?
    let isCenteredVertically: Bool?
    
    public init(
        top: Int? = nil,
        right: Int? = nil,
        bottom: Int? = nil,
        left: Int? = nil,
        width: Int? = nil,
        height: Int? = nil,
        isCenteredHorizontally: Bool? = nil,
        isCenteredVertically: Bool? = nil) {
        self.top = top
        self.right = right
        self.bottom = bottom
        self.left = left
        self.width = width
        self.height = height
        self.isCenteredHorizontally = isCenteredHorizontally
        self.isCenteredVertically = isCenteredVertically
    }
    
    public func top(_ value: Int) -> Layout {
        return Layout(top: value, right: right, bottom: bottom, left: left, width: width, height: height,
                      isCenteredHorizontally: isCenteredHorizontally, isCenteredVertically:isCenteredVertically)
    }
    
    public func bottom(_ value: Int) -> Layout {
        return Layout(top: top, right: right, bottom: -value, left: left, width: width, height: height,
                      isCenteredHorizontally: isCenteredHorizontally, isCenteredVertically:isCenteredVertically)
    }
    
    public func right(_ value: Int) -> Layout {
        return Layout(top: top, right: -value, bottom: bottom, left: left, width: width, height: height,
                      isCenteredHorizontally: isCenteredHorizontally, isCenteredVertically:isCenteredVertically)
    }
    
    public func left(_ value: Int) -> Layout {
        return Layout(top: top, right: right, bottom: bottom, left: value, width: width, height: height,
                      isCenteredHorizontally: isCenteredHorizontally, isCenteredVertically:isCenteredVertically)
    }
    
    public func width(_ value: Int) -> Layout {
        return Layout(top: top, right: right, bottom: bottom, left: left, width: value, height: height,
                      isCenteredHorizontally: isCenteredHorizontally, isCenteredVertically:isCenteredVertically)
    }
    
    public func height(_ value: Int) -> Layout {
        return Layout(top: top, right: right, bottom: bottom, left: left, width: width, height: value,
                      isCenteredHorizontally: isCenteredHorizontally, isCenteredVertically:isCenteredVertically)
    }
    
    public func centerHorizontally() -> Layout {
        return Layout(top: top, right: nil, bottom: bottom, left: nil, width: width, height: height,
                      isCenteredHorizontally: true, isCenteredVertically:isCenteredVertically)
    }
    
    public func centerVertically() -> Layout {
        return Layout(top: nil, right: right, bottom: nil, left: left, width: width, height: height,
                      isCenteredHorizontally: isCenteredHorizontally, isCenteredVertically: true)
    }
    
    public func centered() -> Layout {
        return Layout(top: nil, right: nil, bottom: nil, left: nil, width: width, height: height,
                      isCenteredHorizontally: true, isCenteredVertically: true)
    }
    
    // Helpers
    
    public func size(_ value: Int) -> Layout {
        return Layout(top: top, right: right, bottom: bottom, left: left, width: value, height: value,
                      isCenteredHorizontally: isCenteredHorizontally, isCenteredVertically:isCenteredVertically)
    }
    
    public func fill(padding value: Int? = 0) -> Layout {
        if let v = value, v != 0 {
            return Layout(top: value, right:-v, bottom: -v, left: value, width: width, height: width,
                          isCenteredHorizontally: isCenteredHorizontally, isCenteredVertically:isCenteredVertically)
        }
        
        return Layout(top: value, right:value, bottom: value, left: value, width: width, height: width,
    isCenteredHorizontally: isCenteredHorizontally, isCenteredVertically:isCenteredVertically)}
    
    public func fillHorizontally(padding value: Int? = 0) -> Layout {
        return Layout(top: top, right: value, bottom: bottom, left: value, width: width, height: width,
        isCenteredHorizontally: isCenteredHorizontally, isCenteredVertically:isCenteredVertically)
    }
    
    public func fillVertically(padding value: Int? = 0) -> Layout {
        return Layout(top: value, right: right, bottom: value, left: left, width: width, height: width,
        isCenteredHorizontally: isCenteredHorizontally, isCenteredVertically:isCenteredVertically)
    }
}

public func == (lhs: Layout, rhs: Layout) -> Bool {
    return lhs.top == rhs.top
            && lhs.right == rhs.right
            && lhs.left == rhs.left
            && lhs.bottom == rhs.bottom
            && lhs.width == rhs.width
            && lhs.height == rhs.height
            && lhs.isCenteredHorizontally == rhs.isCenteredHorizontally
            && lhs.isCenteredVertically == rhs.isCenteredVertically
}
