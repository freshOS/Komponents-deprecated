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

//private var startComponentID = 0
//func generateUniqueComponentId() -> Int {
//    startComponentID += 1
//    return startComponentID
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
