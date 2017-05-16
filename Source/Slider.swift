//
//  Slider.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 12/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public struct Slider: Node, Equatable {
    
    public var uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public var children = [IsNode]()
    let props: SliderProps
    public var layout: Layout
    public let ref: UnsafeMutablePointer<UISlider>?
    var registerValueChanged: ((UISlider) -> Void)?
    
    public init(
        _ value: Float = 0,
        changed: ((Float) -> Void)? = nil,
        props:((inout SliderProps) -> Void)? = nil,
        _ layout: Layout? = nil,
        ref: UnsafeMutablePointer<UISlider>? = nil) {
        var defaultProps = SliderProps()
        defaultProps.value = value
        if let p = props {
            var prop = defaultProps
            p(&prop)
            self.props = prop
        } else {
            self.props = defaultProps
        }
        self.layout = layout ?? Layout()
        self.ref = ref
        registerValueChanged = { slider in
            if let slider = slider as? BlockBasedUISlider, let changed = changed {
                slider.setCallback(changed)
            }
        }
    }
}

public func == (lhs: Slider, rhs: Slider) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

public struct SliderProps: Equatable, Hashable {
    
    public var value: Float = 0
    
    public var hashValue: Int {
        return value.hashValue
    }
}

public func == (lhs: SliderProps, rhs: SliderProps) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
