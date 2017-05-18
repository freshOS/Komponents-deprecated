//
//  PageControl.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 12/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public struct PageControl: Node, Equatable {
    
    public var uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public var children = [IsNode]()
    let props: PageControlProps
    public var layout: Layout
    public let ref: UnsafeMutablePointer<UIPageControl>?
    
    public init(props:((inout PageControlProps) -> Void)? = nil,
                _ layout: Layout? = nil,
                ref: UnsafeMutablePointer<UIPageControl>? = nil) {
        let defaultProps = PageControlProps()
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

public func == (lhs: PageControl, rhs: PageControl) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

public struct PageControlProps: Equatable, Hashable {
    
    public var numberOfPages = 0
    public var currentPage = 0
    public var pageIndicatorTintColor: UIColor?
    public var currentPageIndicatorTintColor: UIColor?
    
    public var hashValue: Int {
        return numberOfPages.hashValue
            ^ currentPage.hashValue
            ^ hashFor(pageIndicatorTintColor)
            ^ hashFor(currentPageIndicatorTintColor)
    }
}

public func == (lhs: PageControlProps, rhs: PageControlProps) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
