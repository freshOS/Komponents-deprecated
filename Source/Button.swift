//
//  Button.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 11/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

// support for selector / target
//    public init(_ wording: String = "",
//                image: UIImage? = nil,
//                tap: (Selector, target: Any),
//                style: ((UIButton) -> Void)? = nil,
//                layout: ((UIButton) -> Void)? = nil,
//                ref: UnsafeMutablePointer<UIButton>? = nil) {
//        self.image = image
//        self.wording = wording
//        self.layoutBlock = layout
//        self.styleBlock = style
//        self.ref = ref
//        registerTap = { button in
//            button.addTarget(tap.target, action: tap.0, for: .touchUpInside)
//        }
//    }
//}

public struct Button: Node, Equatable {
    
    public let uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public let children = [IsNode]()
    public var props: ButtonProps
    public let layout: Layout
    public let ref: UnsafeMutablePointer<UIButton>?
    //    var image: UIImage?
    
    var registerTap: ((UIButton) -> Void)?
    
    public init(_ wording: String = "",
         tap: (() -> Void)? = nil,
         props:((inout ButtonProps) -> Void)? = nil,
         layout: Layout? = nil,
         ref: UnsafeMutablePointer<UIButton>? = nil) {

        var defaultProps = ButtonProps()
        defaultProps.text = wording
        if let p = props {
            var prop = defaultProps
            p(&prop)
            self.props = prop
        } else {
            self.props = defaultProps
        }
        self.layout = layout == nil ? Layout() : layout!
        self.ref = ref
        
        registerTap = { button in
            if let button = button as? BlockBasedUIButton, let tap = tap {
                button.setCallback(tap)
            }
        }
    }
    
    func test() {
        
    }
}

public func == (lhs: Button, rhs: Button) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

public struct ButtonProps: Hashable, Equatable {
    
    public var text: String
    
    public mutating func setTitleColor(_ color: UIColor, for state: UIControlState) {
        if state == .normal {
            titleColorForNormalState = color
        }
    }
    
    internal var titleColorForNormalState: UIColor = .white
    
    init(text: String = "") {
        self.text = text
    }
    
    public var hashValue: Int {
        return text.hashValue ^ titleColorForNormalState.hashValue
    }
}

public func == (lhs: ButtonProps, rhs: ButtonProps) -> Bool {
    return lhs.text == rhs.text
        && lhs.titleColorForNormalState == rhs.titleColorForNormalState
}
