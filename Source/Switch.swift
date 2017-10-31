//
//  Switch.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 12/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public struct Switch: Node, Equatable {
    
    public var uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public var children = [IsNode]()
    let props: SwitchProps
    public var layout: Layout
    public let ref: UnsafeMutablePointer<UISwitch>?
    var registerValueChanged: ((UISwitch) -> Void)?
    
    public init(_ on: Bool = false,
                changed: ((Bool) -> Void)? = nil,
                props:((inout SwitchProps) -> Void)? = nil,
                _ layout: Layout? = nil,
                ref: UnsafeMutablePointer<UISwitch>? = nil) {
        var defaultProps = SwitchProps()
        defaultProps.isOn = on
        if let p = props {
            var prop = defaultProps
            p(&prop)
            self.props = prop
        } else {
            self.props = defaultProps
        }
        self.layout = layout ?? Layout()
        self.ref = ref
        
        registerValueChanged = { aSwitch in
            if let aSwitch = aSwitch as? BlockBasedUISwitch, let changed = changed {
                aSwitch.setCallback(changed)
            }
        }
    }
}

public func == (lhs: Switch, rhs: Switch) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

public struct SwitchProps: HasViewProps, Equatable, Hashable {
    
    // HasViewProps
    public var backgroundColor = UIColor.white
    public var borderColor = UIColor.clear
    public var borderWidth: CGFloat = 0
    public var cornerRadius: CGFloat = 0
    public var isHidden = false
    public var alpha: CGFloat = 1
    public var clipsToBounds = false
    public var isUserInteractionEnabled = true
    
    public var isOn = false
    
    public var hashValue: Int {
        return viewPropsHash
            ^ isOn.hashValue
    }
}

public func == (lhs: SwitchProps, rhs: SwitchProps) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
