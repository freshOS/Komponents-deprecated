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

public class Field: Node {
    
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
        textChangedCallback = textChanged
        
        registerTextChanged = { tf in
            tf.addTarget(self, action: #selector(self.textDidChange(tf:)), for: .editingChanged)
        }
    }
    
    @objc
    func textDidChange(tf: UITextField) {
        if let t = tf.text {
            wording = t
            textChangedCallback?(t)
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

public class Button: Node {
    
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
    
        tapCallback = tap
        registerTap = { b in
            b.addTarget(self, action: #selector(self.didTap), for: .touchUpInside)
        }
    }
    
    @objc
    func didTap() {
        tapCallback?()
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
