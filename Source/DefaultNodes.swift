//
//  DefaultNodes.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 31/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation
import UIKit

public struct View: Node {
    
    public var applyStyle: (() -> Void)?
    public var applyLayout: (() -> Void)?
    var layoutBlock: ((UIView) -> Void)?
    var styleBlock: ((UIView) -> Void)?
    public var children = [Renderable]()
    var childrenLayout = [Any]()
    var ref: UnsafeMutablePointer<UIView>?
    
    public init(style: ((UIView) -> Void)? = nil,
                layout: ((UIView) -> Void)? = nil,
                ref: UnsafeMutablePointer<UIView>? = nil,
                _ children:[Renderable]) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
        self.ref = ref
    }
    
    public init(style: ((UIView) -> Void)? = nil,
                layout: ((UIView) -> Void)? = nil,
                ref: UnsafeMutablePointer<UIView>? = nil) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.ref = ref
    }
}

public struct Label: Node {
    
    public var applyStyle: (() -> Void)?
    public var applyLayout: (() -> Void)?
    var layoutBlock: ((UILabel) -> Void)?
    var styleBlock: ((UILabel) -> Void)?
    public var children = [Renderable]()
    var wording = ""
    var ref: UnsafeMutablePointer<UILabel>?
    
    public init(_ wording: String = "",
                style: ((UILabel) -> Void)? = nil,
                layout: ((UILabel) -> Void)? = nil,
                ref: UnsafeMutablePointer<UILabel>? = nil) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.wording = wording
        self.ref = ref
    }
}

public struct Field: Node {
    
    public var applyStyle: (() -> Void)?
    public  var applyLayout: (() -> Void)?
    var layoutBlock: ((UITextField) -> Void)?
    var styleBlock: ((UITextField) -> Void)?
    public var children = [Renderable]()
    var placeholder = ""
    var wording = ""
    var isFocused = true
    var ref: UnsafeMutablePointer<UITextField>?
    
    var textChangedCallback: ((String) -> Void)?
    
    var registerTextChanged: ((UITextField) -> Void)?
    
    public init(_ placeholder: String = "",
                wording: String = "",
                textChanged: ((String) -> Void)? = nil,
                style: ((UITextField) -> Void)? = nil,
                layout: ((UITextField) -> Void)? = nil,
                ref: UnsafeMutablePointer<UITextField>? = nil) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.placeholder = placeholder
        self.wording = wording
        self.ref = ref
        registerTextChanged = { field in
            if let field = field as? BlockBasedUITextField, let textChanged = textChanged {
                field.setCallback(textChanged)
            }
        }
    }
    
    public init(_ placeholder: String = "",
                wording: String = "",
                textChanged: (Selector, target: Any),
                style: ((UITextField) -> Void)? = nil,
                layout: ((UITextField) -> Void)? = nil,
                ref: UnsafeMutablePointer<UITextField>? = nil) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.placeholder = placeholder
        self.wording = wording
        self.ref = ref
        registerTextChanged = { field in
            field.addTarget(textChanged.target, action: textChanged.0, for: .editingChanged)
        }
    }
}

public struct TextView: Node {
    
    public var applyStyle: (() -> Void)?
    public  var applyLayout: (() -> Void)?
    var layoutBlock: ((UITextView) -> Void)?
    var styleBlock: ((UITextView) -> Void)?
    public var children = [Renderable]()
    var wording = ""
    var isFocused = true
    var ref: UnsafeMutablePointer<UITextView>?
    
    var textChangedCallback: ((String) -> Void)?
    
    var registerTextChanged: ((UITextView) -> Void)?
    
    public init(_ wording: String = "",
                textChanged: ((String) -> Void)? = nil,
                style: ((UITextView) -> Void)? = nil,
                layout: ((UITextView) -> Void)? = nil,
                ref: UnsafeMutablePointer<UITextView>? = nil) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.wording = wording
        self.ref = ref
        registerTextChanged = { field in
            if let field = field as? BlockBasedUITextView, let textChanged = textChanged {
                field.setCallback(textChanged)
            }
        }
    }
}

public struct VerticalStack: Node {
    
    public var applyStyle: (() -> Void)?
    public var applyLayout: (() -> Void)?
    var layoutBlock: ((UIStackView) -> Void)?
    var styleBlock: ((UIStackView) -> Void)?
    public var children = [Renderable]()
    
    public init(style: ((UIStackView) -> Void)? = nil,
                layout: ((UIStackView) -> Void)? = nil,
                children: [Renderable] = [Renderable]()) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
    }
    
    public init(style: ((UIStackView) -> Void)? = nil,
                layout: ((UIStackView) -> Void)? = nil,
                _ children: [Renderable]) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
    }
}

public struct HorizontalStack: Node {
    
    public var applyStyle: (() -> Void)?
    public var applyLayout: (() -> Void)?
    var layoutBlock: ((UIStackView) -> Void)?
    var styleBlock: ((UIStackView) -> Void)?
    public var children = [Renderable]()
    
    public init(style: ((UIStackView) -> Void)? = nil,
                layout: ((UIStackView) -> Void)? = nil,
                children: [Renderable] = [Renderable]()) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
    }
    
    public init(style: ((UIStackView) -> Void)? = nil,
                layout: ((UIStackView) -> Void)? = nil,
                _ children: [Renderable]) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
    }
}

public struct Button: Node {
    
    var tapCallback:(() -> Void)?
    
    public var applyStyle: (() -> Void)?
    public var applyLayout: (() -> Void)?
    var layoutBlock: ((UIButton) -> Void)?
    var styleBlock: ((UIButton) -> Void)?
    public var children = [Renderable]()
    var wording = ""
    var image: UIImage?
    var registerTap: ((UIButton) -> Void)?
    var ref: UnsafeMutablePointer<UIButton>?
    
    public init(_ wording: String = "",
                image: UIImage? = nil,
                tap: (() -> Void)? = nil,
                style: ((UIButton) -> Void)? = nil,
                layout: ((UIButton) -> Void)? = nil,
                ref: UnsafeMutablePointer<UIButton>? = nil) {
        self.image = image
        self.wording = wording
        self.layoutBlock = layout
        self.styleBlock = style
        self.ref = ref
        registerTap = { button in
            if let button = button as? BlockBasedUIButton, let tap = tap {
                button.setCallback(tap)
            }
        }
    }
    
    public init(_ wording: String = "",
                image: UIImage? = nil,
                tap: (Selector, target: Any),
                style: ((UIButton) -> Void)? = nil,
                layout: ((UIButton) -> Void)? = nil,
                ref: UnsafeMutablePointer<UIButton>? = nil) {
        self.image = image
        self.wording = wording
        self.layoutBlock = layout
        self.styleBlock = style
        self.ref = ref
        registerTap = { button in
            button.addTarget(tap.target, action: tap.0, for: .touchUpInside)
        }
    }
}

public struct Image: Node {
    
    public var applyStyle: (() -> Void)?
    public var applyLayout: (() -> Void)?
    var layoutBlock: ((UIImageView) -> Void)?
    var styleBlock: ((UIImageView) -> Void)?
    public var children = [Renderable]()
    var ref: UnsafeMutablePointer<UIImageView>?
    var image: UIImage?
    
    public init(_ image: UIImage? = nil,
                style: ((UIView) -> Void)? = nil,
                layout: ((UIImageView) -> Void)? = nil,
                ref: UnsafeMutablePointer<UIImageView>? = nil) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.ref = ref
        self.image = image
    }
}

public struct ScrollView: Node {
    
    public var applyStyle: (() -> Void)?
    public var applyLayout: (() -> Void)?
    var layoutBlock: ((UIScrollView) -> Void)?
    var styleBlock: ((UIScrollView) -> Void)?
    public var children = [Renderable]()
    var childrenLayout = [Any]()
    var ref: UnsafeMutablePointer<UIScrollView>?
    
    public init(style: ((UIScrollView) -> Void)? = nil,
                layout: ((UIScrollView) -> Void)? = nil,
                ref: UnsafeMutablePointer<UIScrollView>? = nil,
                _ children: [Renderable]) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
        self.ref = ref
    }
    
    public init(style: ((UIScrollView) -> Void)? = nil,
                layout: ((UIScrollView) -> Void)? = nil,
                ref: UnsafeMutablePointer<UIScrollView>? = nil) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.ref = ref
    }
}

public struct PageControl: Node {
    
    public var applyStyle: (() -> Void)?
    public var applyLayout: (() -> Void)?
    var layoutBlock: ((UIPageControl) -> Void)?
    var styleBlock: ((UIPageControl) -> Void)?
    public var children = [Renderable]()
    var ref: UnsafeMutablePointer<UIPageControl>?
    
    public init(style: ((UIPageControl) -> Void)? = nil,
                layout: ((UIPageControl) -> Void)? = nil,
                ref: UnsafeMutablePointer<UIPageControl>? = nil) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.ref = ref
    }
}

public struct ActivityIndicatorView: Node {
    
    public var applyStyle: (() -> Void)?
    public var applyLayout: (() -> Void)?
    var layoutBlock: ((UIActivityIndicatorView) -> Void)?
    var styleBlock: ((UIActivityIndicatorView) -> Void)?
    public var children = [Renderable]()

    var ref: UnsafeMutablePointer<UIActivityIndicatorView>?
    var activityIndicatorStyle = UIActivityIndicatorViewStyle.gray
    
    public init(_ activityIndicatorStyle: UIActivityIndicatorViewStyle = .gray,
                style: ((UIActivityIndicatorView) -> Void)? = nil,
                layout: ((UIActivityIndicatorView) -> Void)? = nil,
                ref: UnsafeMutablePointer<UIActivityIndicatorView>? = nil) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.ref = ref
        self.activityIndicatorStyle = activityIndicatorStyle
    }
}

public struct Slider: Node {
    
    public var applyStyle: (() -> Void)?
    public var applyLayout: (() -> Void)?
    var layoutBlock: ((UISlider) -> Void)?
    var styleBlock: ((UISlider) -> Void)?
    public var children = [Renderable]()
    var value:Float = 0
    var ref: UnsafeMutablePointer<UISlider>?
    
    var registerValueChanged: ((UISlider) -> Void)?
    
    public init(_ value: Float,
                changed: (Selector, target: Any),
                style: ((UISlider) -> Void)? = nil,
                layout: ((UISlider) -> Void)? = nil,
                ref: UnsafeMutablePointer<UISlider>? = nil) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.value = value
        self.ref = ref
        
        registerValueChanged = { slider in
            slider.addTarget(changed.target, action: changed.0, for: .valueChanged)
        }
    }
    
    public init(_ value: Float,
                changed: ((Float) -> Void)? = nil,
                style: ((UISlider) -> Void)? = nil,
                layout: ((UISlider) -> Void)? = nil,
                ref: UnsafeMutablePointer<UISlider>? = nil) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.value = value
        self.ref = ref
        registerValueChanged = { slider in
            if let slider = slider as? BlockBasedUISlider, let changed = changed {
                slider.setCallback(changed)
            }
        }
    }
}

public struct Switch: Node {
    
    public var applyStyle: (() -> Void)?
    public var applyLayout: (() -> Void)?
    var layoutBlock: ((UISwitch) -> Void)?
    var styleBlock: ((UISwitch) -> Void)?
    public var children = [Renderable]()
    var isOn: Bool = false
    var ref: UnsafeMutablePointer<UISwitch>?
    
    var registerValueChanged: ((UISwitch) -> Void)?
    
    public init(_ on: Bool = false,
                changed: (Selector, target: Any),
                style: ((UISwitch) -> Void)? = nil,
                layout: ((UISwitch) -> Void)? = nil,
                ref: UnsafeMutablePointer<UISwitch>? = nil) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.isOn = on
        self.ref = ref

        registerValueChanged = { aSwitch in
            aSwitch.addTarget(changed.target, action: changed.0, for: .valueChanged)
        }
    }
    
    public init(_ on: Bool = false,
                changed: ((Bool) -> Void)? = nil,
                style: ((UISwitch) -> Void)? = nil,
                layout: ((UISwitch) -> Void)? = nil,
                ref: UnsafeMutablePointer<UISwitch>? = nil) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.isOn = on
        self.ref = ref
        registerValueChanged = { aSwitch in
            if let aSwitch = aSwitch as? BlockBasedUISwitch, let changed = changed {
                aSwitch.setCallback(changed)
            }
        }
    }
    
}



// Block Based UIControls

class BlockBasedUITextField: UITextField {
    
    public var actionHandler: ((String) -> Void)?
    
    public func setCallback(_ callback :@escaping ((String) -> Void)) {
        actionHandler = callback
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func textDidChange(field: UITextField) {
        if let text = field.text {
            actionHandler?(text)
        }
    }
}

class BlockBasedUITextView: UITextView, UITextViewDelegate {
    
    public var actionHandler: ((String) -> Void)?
    
    public func setCallback(_ callback :@escaping ((String) -> Void)) {
        actionHandler = callback
        delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let text = textView.text {
            actionHandler?(text)
        }
    }
}

class BlockBasedUIButton: UIButton {
    
    public var actionHandler: (() -> Void)?
    
    public func setCallback(_ callback :@escaping (() -> Void)) {
        actionHandler = callback
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    func didTap() {
        actionHandler?()
    }
}

class BlockBasedUISlider: UISlider {
    
    public var actionHandler: ((Float) -> Void)?
    
    public func setCallback(_ callback :@escaping ((Float) -> Void)) {
        actionHandler = callback
        addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    func sliderValueChanged(sender: UISlider) {
        actionHandler?(sender.value)
    }
}

class BlockBasedUISwitch: UISwitch {
    
    public var actionHandler: ((Bool) -> Void)?

    public func setCallback(_ callback :@escaping ((Bool) -> Void)) {
        actionHandler = callback
        addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    }
    
    func switchValueChanged(sender: UISwitch) {
        actionHandler?(sender.isOn)
    }
}


// Left to implement.
//SegmentedControl ProgressView Stepper TableView CollectionView TableViewCell CollectionViewCell DatePicker PickerView VisualEffectView MapKitView Webview TapGestureRecognizer PinchGestureRecognizers RotationGestureRecognizers SwipeGestureRecognizers Toolbar SearchBar
