//
//  DefaultNodes.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 31/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import Foundation
import UIKit

struct View: Node {
    
    var applyStyle: (() -> Void)?
    var applyLayout: (() -> Void)?
    var layoutBlock: ((UIView) -> Void)?
    var styleBlock: ((UIView) -> Void)?
    var children = [Node]()
    var childrenLayout = [Any]()
    var ref: UnsafeMutablePointer<UIView>?
    
    init(style: ((UIView) -> Void)? = nil, layout: ((UIView) -> Void)? = nil,
         ref: UnsafeMutablePointer<UIView>? = nil, _ children:[Any]) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.childrenLayout = children
        self.ref = ref
    }
    
    init(style: ((UIView) -> Void)? = nil, layout: ((UIView) -> Void)? = nil,
         ref: UnsafeMutablePointer<UIView>? = nil) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.ref = ref
    }
}

struct Label: Node {
    
    var applyStyle: (() -> Void)?
    var applyLayout: (() -> Void)?
    var layoutBlock: ((UILabel) -> Void)?
    var styleBlock: ((UILabel) -> Void)?
    var children = [Node]()
    var wording = ""
    var ref: UnsafeMutablePointer<UILabel>?
    
    init(_ wording: String = "",
         style: ((UILabel) -> Void)? = nil,
         layout: ((UILabel) -> Void)? = nil,
         ref: UnsafeMutablePointer<UILabel>? = nil, children: [Node] = [Node]() ) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
        self.wording = wording
        self.ref = ref
    }
}

class Field: Node {
    
    var applyStyle: (() -> Void)?
    var applyLayout: (() -> Void)?
    var layoutBlock: ((UITextField) -> Void)?
    var styleBlock: ((UITextField) -> Void)?
    var children = [Node]()
    var placeholder = ""
    var wording = ""
    var isFocused = true
    
    var textChangedCallback: ((String) -> Void)?
    
    var registerTextChanged: ((UITextField) -> Void)?
    
    init(_ placeholder: String = "",
         wording: String = "",
         textChanged: ((String) -> Void)? = nil,
         style: ((UITextField) -> Void)? = nil,
         layout: ((UITextField) -> Void)? = nil,
         children: [Node] = [Node]()) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
        self.placeholder = placeholder
        self.wording = wording
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

struct VerticalStack: Node {
    
    var applyStyle: (() -> Void)?
    var applyLayout: (() -> Void)?
    var layoutBlock: ((UIStackView) -> Void)?
    var styleBlock: ((UIStackView) -> Void)?
    var children = [Node]()
    
    init(style: ((UIStackView) -> Void)? = nil,
         layout: ((UIStackView) -> Void)? = nil,
         children: [Node] = [Node]()) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
    }
    
    init(style: ((UIStackView) -> Void)? = nil,
         layout: ((UIStackView) -> Void)? = nil,
         _ children: [Node]) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
    }
}

struct HorizontalStack: Node {
    
    var applyStyle: (() -> Void)?
    var applyLayout: (() -> Void)?
    var layoutBlock: ((UIStackView) -> Void)?
    var styleBlock: ((UIStackView) -> Void)?
    var children = [Node]()
    
    init(style: ((UIStackView) -> Void)? = nil,
         layout: ((UIStackView) -> Void)? = nil,
         children: [Node] = [Node]()) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
    }
    
    init(style: ((UIStackView) -> Void)? = nil,
         layout: ((UIStackView) -> Void)? = nil,
         _ children: [Node]) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
    }
}

class Button: Node {
    
    var tapCallback:(() -> Void)?
    
    var applyStyle: (() -> Void)?
    var applyLayout: (() -> Void)?
    var layoutBlock: ((UIButton) -> Void)?
    var styleBlock: ((UIButton) -> Void)?
    var children = [Node]()
    var wording = ""
    var image: UIImage?
    
    var registerTap: ((UIButton) -> Void)?
    var ref: UnsafeMutablePointer<UIButton>?
    
    init(_ wording: String = "",
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

struct Image: Node {
    
    var applyStyle: (() -> Void)?
    var applyLayout: (() -> Void)?
    var layoutBlock: ((UIImageView) -> Void)?
    var styleBlock: ((UIImageView) -> Void)?
    var children = [Node]()
    var childrenLayout = [Any]()
    var ref: UnsafeMutablePointer<UIImageView>?
    var image: UIImage?
    
    init(_ image: UIImage? = nil,
         style: ((UIView) -> Void)? = nil,
         layout: ((UIImageView) -> Void)? = nil,
         ref: UnsafeMutablePointer<UIImageView>? = nil, _ children:[Any]) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.childrenLayout = children
        self.ref = ref
        self.image = image
    }
    
    init(_ image: UIImage? = nil,
         style: ((UIView) -> Void)? = nil,
         layout: ((UIImageView) -> Void)? = nil,
         ref: UnsafeMutablePointer<UIImageView>? = nil) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.ref = ref
        self.image = image
    }
}

struct ScrollView: Node {
    
    var applyStyle: (() -> Void)?
    var applyLayout: (() -> Void)?
    var layoutBlock: ((UIScrollView) -> Void)?
    var styleBlock: ((UIScrollView) -> Void)?
    var children = [Node]()
    var childrenLayout = [Any]()
    var ref: UnsafeMutablePointer<UIScrollView>?
    
    init(style: ((UIScrollView) -> Void)? = nil,
         layout: ((UIScrollView) -> Void)? = nil,
         ref: UnsafeMutablePointer<UIScrollView>? = nil,
         _ children:[Any]) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.childrenLayout = children
        self.ref = ref
    }
    
    init(style: ((UIScrollView) -> Void)? = nil,
         layout: ((UIScrollView) -> Void)? = nil,
         ref: UnsafeMutablePointer<UIScrollView>? = nil) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.ref = ref
    }
}

struct PageControl: Node {
    
    var applyStyle: (() -> Void)?
    var applyLayout: (() -> Void)?
    var layoutBlock: ((UIPageControl) -> Void)?
    var styleBlock: ((UIPageControl) -> Void)?
    var children = [Node]()
    var childrenLayout = [Any]()
    var ref: UnsafeMutablePointer<UIPageControl>?
    
    init(style: ((UIPageControl) -> Void)? = nil,
         layout: ((UIPageControl) -> Void)? = nil,
         ref: UnsafeMutablePointer<UIPageControl>? = nil,
         _ children: [Any]) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.childrenLayout = children
        self.ref = ref
    }
    
    init(style: ((UIPageControl) -> Void)? = nil, layout: ((UIPageControl) -> Void)? = nil,
         ref: UnsafeMutablePointer<UIPageControl>? = nil) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.ref = ref
    }
}

struct ActivityIndicatorView: Node {
    
    var applyStyle: (() -> Void)?
    var applyLayout: (() -> Void)?
    var layoutBlock: ((UIActivityIndicatorView) -> Void)?
    var styleBlock: ((UIActivityIndicatorView) -> Void)?
    var children = [Node]()
    var childrenLayout = [Any]()
    var ref: UnsafeMutablePointer<UIActivityIndicatorView>?
    var activityIndicatorStyle = UIActivityIndicatorViewStyle.gray
    
    init(_ activityIndicatorStyle: UIActivityIndicatorViewStyle = .gray,
         style: ((UIView) -> Void)? = nil,
         layout: ((UIActivityIndicatorView) -> Void)? = nil,
         ref: UnsafeMutablePointer<UIActivityIndicatorView>? = nil,
         _ children:[Any]) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.childrenLayout = children
        self.ref = ref
        self.activityIndicatorStyle = activityIndicatorStyle
    }
    
    init(_ activityIndicatorStyle: UIActivityIndicatorViewStyle = .gray,
         style: ((UIActivityIndicatorView) -> Void)? = nil,
         layout: ((UIActivityIndicatorView) -> Void)? = nil,
         ref: UnsafeMutablePointer<UIActivityIndicatorView>? = nil) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.ref = ref
        self.activityIndicatorStyle = activityIndicatorStyle
    }
}
