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
    
    public var uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public let children = [IsNode]()
    public var props: ButtonProps
    public var layout: Layout
    public let ref: UnsafeMutablePointer<UIButton>?
    
    var registerTap: ((UIButton) -> Void)?
    
    public init(_ wording: String = "",
                image: UIImage? = nil,
                tap: (() -> Void)? = nil,
                props:((inout ButtonProps) -> Void)? = nil,
                layout: Layout? = nil,
                ref: UnsafeMutablePointer<UIButton>? = nil) {

        var defaultProps = ButtonProps()
        defaultProps.text = wording
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

public struct ButtonProps: HasViewProps, Hashable, Equatable {
    
    // HasViewProps
    public var backgroundColor = UIColor.white
    public var borderColor = UIColor.clear
    public var borderWidth: CGFloat = 0
    public var cornerRadius: CGFloat = 0
    public var isHidden = false
    public var alpha: CGFloat = 1
    public var clipsToBounds = false
    public var isUserInteractionEnabled = true
    
    public init() {
        text = ""
    }
    
    public var text: String
    public var image: UIImage?
    public var font: UIFont?
    public var isEnabled = true
    
    public mutating func setTitleColor(_ color: UIColor, for state: UIControl.State) {
        if state == .normal {
            titleColorForNormalState = color
        }
        if state == .highlighted {
            titleColorForHighlightedState = color
        }
    }
    
    internal var titleColorForNormalState: UIColor = .white
    internal var titleColorForHighlightedState: UIColor = .white
    
    public mutating func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        if state == .normal {
            backgroundColorForNormalState = color
        }
        if state == .highlighted {
            backgroundForHighlightedState = color
        }
    }
    
    internal var backgroundColorForNormalState: UIColor?
    internal var backgroundForHighlightedState: UIColor?
    
    init(text: String = "") {
        self.text = text
    }
    
    public var hashValue: Int {
        return viewPropsHash
            ^ text.hashValue
            ^ titleColorForNormalState.hashValue
            ^ titleColorForHighlightedState.hashValue
            ^ isEnabled.hashValue
            ^ hashFor(backgroundColorForNormalState)
            ^ hashFor(backgroundForHighlightedState)
            ^ hashFor(image)
            ^ hashFor(font)
        
    }
}

public func == (lhs: ButtonProps, rhs: ButtonProps) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
