//
//  DefaultNodes.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 31/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation
import UIKit
import MapKit


// TODO ref . referencable protocol??

private var startID = 0
func generateUniqueId() -> Int {
    startID += 1
    return startID
}


//public struct Field: Node {
//    
//    public var applyStyle: (() -> Void)?
//    public  var applyLayout: (() -> Void)?
//    var layoutBlock: ((UITextField) -> Void)?
//    var styleBlock: ((UITextField) -> Void)?
//    public var children = [Renderable]()
//    var placeholder = ""
//    var wording = ""
//    var isFocused = true
//    var ref: UnsafeMutablePointer<UITextField>?
//    
//    var textChangedCallback: ((String) -> Void)?
//    
//    var registerTextChanged: ((UITextField) -> Void)?
//    
//    public init(_ placeholder: String = "",
//                wording: String = "",
//                textChanged: ((String) -> Void)? = nil,
//                style: ((UITextField) -> Void)? = nil,
//                layout: ((UITextField) -> Void)? = nil,
//                ref: UnsafeMutablePointer<UITextField>? = nil) {
//        self.layoutBlock = layout
//        self.styleBlock = style
//        self.placeholder = placeholder
//        self.wording = wording
//        self.ref = ref
//        registerTextChanged = { field in
//            if let field = field as? BlockBasedUITextField, let textChanged = textChanged {
//                field.setCallback(textChanged)
//            }
//        }
//    }
//    
//    public init(_ placeholder: String = "",
//                wording: String = "",
//                textChanged: (Selector, target: Any),
//                style: ((UITextField) -> Void)? = nil,
//                layout: ((UITextField) -> Void)? = nil,
//                ref: UnsafeMutablePointer<UITextField>? = nil) {
//        self.layoutBlock = layout
//        self.styleBlock = style
//        self.placeholder = placeholder
//        self.wording = wording
//        self.ref = ref
//        registerTextChanged = { field in
//            field.addTarget(textChanged.target, action: textChanged.0, for: .editingChanged)
//        }
//    }
//}

//public struct TextView: Node {
//    
//    public var applyStyle: (() -> Void)?
//    public  var applyLayout: (() -> Void)?
//    var layoutBlock: ((UITextView) -> Void)?
//    var styleBlock: ((UITextView) -> Void)?
//    public var children = [Renderable]()
//    var wording = ""
//    var isFocused = true
//    var ref: UnsafeMutablePointer<UITextView>?
//    
//    var textChangedCallback: ((String) -> Void)?
//    
//    var registerTextChanged: ((UITextView) -> Void)?
//    
//    public init(_ wording: String = "",
//                textChanged: ((String) -> Void)? = nil,
//                style: ((UITextView) -> Void)? = nil,
//                layout: ((UITextView) -> Void)? = nil,
//                ref: UnsafeMutablePointer<UITextView>? = nil) {
//        self.layoutBlock = layout
//        self.styleBlock = style
//        self.wording = wording
//        self.ref = ref
//        registerTextChanged = { field in
//            if let field = field as? BlockBasedUITextView, let textChanged = textChanged {
//                field.setCallback(textChanged)
//            }
//        }
//    }
//}



//public struct ScrollView: Node {
//    
//    public var applyStyle: (() -> Void)?
//    public var applyLayout: (() -> Void)?
//    var layoutBlock: ((UIScrollView) -> Void)?
//    var styleBlock: ((UIScrollView) -> Void)?
//    public var children = [Renderable]()
//    var childrenLayout = [Any]()
//    var ref: UnsafeMutablePointer<UIScrollView>?
//    
//    public init(style: ((UIScrollView) -> Void)? = nil,
//                layout: ((UIScrollView) -> Void)? = nil,
//                ref: UnsafeMutablePointer<UIScrollView>? = nil,
//                _ children: [Renderable]) {
//        self.layoutBlock = layout
//        self.styleBlock = style
//        self.children = children
//        self.ref = ref
//    }
//    
//    public init(style: ((UIScrollView) -> Void)? = nil,
//                layout: ((UIScrollView) -> Void)? = nil,
//                ref: UnsafeMutablePointer<UIScrollView>? = nil) {
//        self.layoutBlock = layout
//        self.styleBlock = style
//        self.ref = ref
//    }
//}

public typealias EndRefreshingCallback = () -> Void

public typealias ShouldDeleteBlock = (Bool) -> Void
//
//public typealias DeleteCallback = (Int, ShouldDeleteBlock) -> Void


//public struct Table: Node {
//    
//    public var applyStyle: (() -> Void)?
//    public var applyLayout: (() -> Void)?
//    var layoutBlock: ((UITableView) -> Void)?
//    var styleBlock: ((UITableView) -> Void)?
//    public var children = [Renderable]()
//    public var cells = [Renderable]()
//    var tableStyle: UITableViewStyle = .plain
//    var ref: UnsafeMutablePointer<UITableView>?
//    var refreshCallback: (( @escaping EndRefreshingCallback) -> Void)?
//    var deleteCallback: ((Int, @escaping ShouldDeleteBlock) -> Void)?
//    
//    
//    public init(_ tableStyle: UITableViewStyle = .plain,
//                refresh: ((@escaping EndRefreshingCallback) -> Void)? = nil,
//                delete: ((Int, @escaping ShouldDeleteBlock) -> Void)? = nil,
//                style: ((UITableView) -> Void)? = nil,
//                layout: ((UITableView) -> Void)? = nil,
//                ref: UnsafeMutablePointer<UITableView>? = nil,
//                _ cells:[Renderable]) {
//        self.layoutBlock = layout
//        self.styleBlock = style
//        self.tableStyle = tableStyle
//        self.ref = ref
//        self.cells = cells
//        self.refreshCallback = refresh
//        self.deleteCallback = delete
//        
//    }
//}

//public struct Map: Node {
//    
//    public var applyStyle: (() -> Void)?
//    public var applyLayout: (() -> Void)?
//    var layoutBlock: ((MKMapView) -> Void)?
//    var styleBlock: ((MKMapView) -> Void)?
//    public var children = [Renderable]()
//    var wording = ""
//    var ref: UnsafeMutablePointer<MKMapView>?
//    
//    public init(style: ((MKMapView) -> Void)? = nil,
//                layout: ((MKMapView) -> Void)? = nil,
//                ref: UnsafeMutablePointer<MKMapView>? = nil) {
//        self.layoutBlock = layout
//        self.styleBlock = style
//        self.ref = ref
//    }
//}

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

class BlockBasedUIRefreshControl: UIRefreshControl {
    
    public var actionHandler: ((@escaping EndRefreshingCallback) -> Void)?
    
    public func setCallback(_ callback :@escaping (( @escaping EndRefreshingCallback) -> Void)) {
        actionHandler = callback
        addTarget(self, action: #selector(refreshCallback), for: .valueChanged)
    }
    
    func refreshCallback(sender: UIRefreshControl) {
        actionHandler?({
            self.endRefreshing()
        })
    }
}

// Left to implement.
//SegmentedControl Stepper TableView CollectionView TableViewCell CollectionViewCell DatePicker PickerView VisualEffectView MapKitView Webview TapGestureRecognizer PinchGestureRecognizers RotationGestureRecognizers SwipeGestureRecognizers Toolbar SearchBar



class CallBackTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var nbOfSections: Int = 1
    var numberOfRows:(() -> Int)?
    var numberOfRowsInSection: ((Int) -> Int)?
    var cellForRowAt: ((UITableView, IndexPath) -> UITableViewCell)?
    var didSelectRowAt: ((IndexPath) -> Void)?
    var didDeleteRowAt: ((IndexPath) -> Void)?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        dataSource = self
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return nbOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows?() ?? numberOfRowsInSection?(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellForRowAt = cellForRowAt {
            return cellForRowAt(tableView, indexPath)
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAt?(indexPath)
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            didDeleteRowAt?(indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return didDeleteRowAt != nil
    }
}
