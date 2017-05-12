//
//  UIKitRenderer.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit
import MapKit

class UIKitRenderer {
    
    weak var engine: KomponentsEngine!
    
    var nodeIdViewMap = [Int: UIView]()
    var componentIdNodeIdViewMap = [String: Int]()
    
    func viewForComponent(component: IsComponent) -> UIView {
        
        
        let id:String = component.uniqueComponentIdentifier
        print(id)
        print(nodeIdViewMap)
        print(componentIdNodeIdViewMap)
        let nodeId = componentIdNodeIdViewMap[id]!
        return nodeIdViewMap[nodeId]!
    }
    
//    func render(tree:Tree) -> UIView {
//         //Hacky
//        let v = UIView()
//        render(tree: tree, in: v)
//        return v.subviews[0]
//    }
    
    func render(tree:Tree, in view: UIView) {
        
        var tree = tree
        
//        nodeIdViewMap = [Int: UIView]() //Reset
        let newView = viewForNode(node: tree)
        
        //set ref
        if let tree = tree as? View {
            tree.ref?.pointee = newView
        }
        
//        if let subComponenet = tree as? IsComponent {
//            let subTree = subComponenet.render()
//            tree = subTree
//            
//            let cId = subComponenet.uniqueIdentifier
//            componentIdNodeIdViewMap[cId] = tree.uniqueIdentifier
//            
//            //                render(tree: subTree, in: newView)
//        } else {
            nodeIdViewMap[tree.uniqueIdentifier] = newView // todo use same table for Compoenents?
//        }
        

        for c in tree.children {
            // replace child carrement?
            if let subComponenet = c as? IsComponent {
                let subTree = subComponenet.render()
                render(tree: subTree, in: newView)
                subComponenet.didRender()
            } else {
                render(tree: c, in: newView)
            }
        }
        
        
        // Use autolayout
        newView.translatesAutoresizingMaskIntoConstraints = false
        if let stackView = view as? UIStackView {
            stackView.addArrangedSubview(newView)
        } else {
            view.addSubview(newView)
        }
        
        // add autolayout constraints. // TODO func
        if tree.layout.isCenteredVertically == true {
            newView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
        if tree.layout.isCenteredHorizontally == true {
            newView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
        if let top = tree.layout.top {
            newView.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(top)).isActive = true
        }
        if let bottom = tree.layout.bottom {
            newView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat(bottom)).isActive = true
        }
        if let right = tree.layout.right {
            newView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: CGFloat(right)).isActive = true
        }
        if let left = tree.layout.left {
            newView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(left)).isActive = true
        }
        if let height = tree.layout.height {
            newView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        }
        if let width = tree.layout.width {
            newView.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
        }
        
        
        // Plug events
        if let bNode = tree as? Button {
            bNode.registerTap?(newView as! UIButton)
        }
        if let switchNode = tree as? Switch {
            switchNode.registerValueChanged?(newView as! UISwitch)
        }
        if let sliderNode = tree as? Slider {
            sliderNode.registerValueChanged?(newView as! UISlider)
        }
        if let fieldNode = tree as? Field {
            fieldNode.registerTextChanged?(newView as! UITextField)
        }
    }
    
    func viewForNode(node:IsNode) -> UIView {
        
        if let node = node as? View {
            let v = UIView()
            v.backgroundColor = node.props.backgroundColor
            v.layer.borderColor = node.props.borderColor.cgColor
            v.layer.borderWidth = node.props.borderWidth
            v.layer.cornerRadius = node.props.cornerRadius
            v.layer.anchorPoint = node.props.anchorPoint
            return v
        }
        
        if let node = node as? Label {
            let l = UILabel()
            l.text = node.props.text
            return l
        }
        
        if let node = node as? Field {
            let v = BlockBasedUITextField()
            v.placeholder = node.props.placeholder
            v.text = node.props.text
            return v
        }
        
        if let node = node as? Image {
            let v = UIImageView()
            v.image = node.props.image
            v.contentMode = node.props.contentMode
            return v
        }
        
        if let node = node as? Switch {
            let v = BlockBasedUISwitch()
            v.isOn = node.props.isOn
            return v
        }
        
        if let node = node as? Slider {
            let v = BlockBasedUISlider()
            v.value = node.props.value
            return v
        }
        
        if let node = node as? Progress {
            let v = UIProgressView()
            v.progress = node.props.progress
            return v
        }
        
        if let node = node as? Map {
            let v = MKMapView()
            return v
        }
        
        if let node = node as? PageControl {
            let v = UIPageControl()
            v.numberOfPages = node.props.numberOfPages
            v.currentPage = node.props.currentPage
            v.pageIndicatorTintColor = node.props.pageIndicatorTintColor
            v.currentPageIndicatorTintColor = node.props.currentPageIndicatorTintColor
            return v
        }
        
        if let node = node as? ActivityIndicatorView {
            let v = UIActivityIndicatorView(activityIndicatorStyle: node.props.activityIndicatorStyle)
            v.startAnimating()
            return v
        }
        
        if let node = node as? HorizontalStack {
            let v = UIStackView()
            v.axis = .horizontal
            v.spacing = node.props.spacing
            return v
        }
        if let node = node as? VerticalStack {
            let v = UIStackView()
            v.axis = .vertical
            v.spacing = node.props.spacing
            return v
        }
        
        if let node = node as? Button {
            let v = BlockBasedUIButton()
            v.setTitle(node.props.text, for: .normal)
            v.setTitleColor(node.props.titleColorForNormalState, for: .normal)
            v.setTitleColor(node.props.titleColorForHighlightedState, for: .highlighted)
            return v
        }
        
        if var node = node as? Table {
            let table = CallBackTableView(frame: CGRect.zero, style: node.tableStyle)
            table.estimatedRowHeight = 100

            if let rc = node.refreshCallback {
                let refreshControl = BlockBasedUIRefreshControl()
                table.addSubview(refreshControl)
                refreshControl.setCallback(rc)
            }

            table.numberOfRows = {
                return node.cells.count
            }
            table.cellForRowAt = { tbv, ip in
                if ip.section == 0 {
                    let child = node.cells[ip.row]
                    return ComponentCell(component: child)
                }
                return UITableViewCell()
            }
        
            if let deleteCallback = node.deleteCallback {
                table.didDeleteRowAt = { ip in
                    let shouldDeleteBlock = { (b:Bool) in
                        if b {
                            // Remove cell
                            node.cells.remove(at: ip.row)
                            // Delete corresponding row.
                            table.deleteRows(at: [ip], with: .none)
                        } else {
                            table.reloadRows(at: [ip], with: .none)
                        }
                    }
                    deleteCallback(ip.row, shouldDeleteBlock)
                }
            }
            return table
        }
        
        return UIView()
    }
}

//class OldUIKitRenderer: Renderer {
//    
//    weak var engine: KomponentsEngine!
//    weak var parentComponent: IsComponent?
//    
//    func render(_ renderable: Renderable,
//                in rootView: UIView,
//                withEngine: KomponentsEngine,
//                atIndex: Int? = nil,
//                ignoreRefs: Bool = false) {
//        
//        if rootView.superview != nil {
//            if let c = renderable as? IsComponent, Komponents.logsEnabled {
//                print("⚛️ Rendering \(c) : \(c.uniqueIdentifier)")
//            }
//        }
//        
//        
//        engine = withEngine
//
//        
//        
//        if let cell = rootView as? UITableViewCell {
//            
//            
//            let compoenentRootView = viewFor(renderable: renderable, in:cell.contentView, atIndex: atIndex, ignoreRefs: ignoreRefs) //recursive
//            
//        
//    
//                compoenentRootView.fillContainer()
//            
//            
//            if let c = renderable as? IsComponent {
//                c.didRender()
//            }
//            if renderable is UIViewController || renderable is UIView {
//                compoenentRootView.fillContainer()
//            }
//            
//            if let c = renderable as? IsComponent {
//                c.didRender()
//            }
//        } else {
//            let compoenentRootView = viewFor(renderable: renderable, in:rootView, atIndex: atIndex, ignoreRefs: ignoreRefs) //recursive
//            
//            if renderable is UIViewController || renderable is UIView {
//                compoenentRootView.fillContainer()
//            }
//            
//            if let c = renderable as? IsComponent {
//                c.didRender()
//            }
//        }
//    }
//    
//    @discardableResult
//    func viewFor(renderable: Renderable, in parentView: UIView, atIndex: Int? = nil, ignoreRefs: Bool) -> UIView {
//        
//        // Store Parent component to associated it with its future children.
//        if let c = renderable as? IsComponent, c is UIViewController || c is UIView {
//            parentComponent = c
//        }
//    
//        var theView: UIView?
//        var node = renderable.render()
//        

//        
//        if let mapNode = node as? Map {
//            // MKMapView cannot be created in a BG thread !!
//            DispatchQueue.main.sync {
//                let map = MKMapView()
//                theView = map
//                node.applyLayout = {
//                    mapNode.layoutBlock?(map)
//                }
//                node.applyStyle = {
//                    mapNode.styleBlock?(map)
//                }
//                if !ignoreRefs{
//                    mapNode.ref?.pointee = map
//                }
//            }
//        }
//        
//        let testLayoutBlock = { }
//        
//        if let theView = theView {
//            
//            
//            // Single node inside View: use fillContainer as default layout.
//            if node is View {
//                if node.children.count == 1 {
//                    if var singleChild = node.children[0] as? VerticalStack {
//                        if singleChild.layoutBlock == nil {
//                            singleChild.layoutBlock = {
//                                $0.fillContainer()
//                            }
//                            node.children[0] = singleChild
//                        }
//                    }
//                    
//                }
//            }
//            
//            
//            // TEST
//            // Fill view children by default if the view nor the children have 
//            //  layout specified.
//            if node is View {
//                
//                var hasNolayout = false
//                
//                if let view = node as? View {
//                    if view.layoutBlock == nil {
//                        hasNolayout = true
//                    }
//                }
//                
//                
//                if hasNolayout {
//                    node.children = node.children.map { c in
//                        
//                        //TODO refactor
//                        
//                        // View child
//                        if var c = c as? View {
//                            if c.layoutBlock == nil {
//                                c.layoutBlock = {
//                                    $0.fillContainer()
//                                }
//                                return c
//                            }
//                        }
//                        
//                        // Button child
//                        if var c = c as? Button {
//                            if c.layoutBlock == nil {
//                                c.layoutBlock = {
//                                    $0.fillContainer()
//                                }
//                                return c
//                            }
//                        }
//                        
//                        // Image child
//                        if var c = c as? Image {
//                            if c.layoutBlock == nil {
//                                c.layoutBlock = {
//                                    $0.fillContainer()
//                                }
//                                return c
//                            }
//                        }
//                        
//                        // Map child
//                        if var c = c as? Map {
//                            if c.layoutBlock == nil {
//                                c.layoutBlock = {
//                                    $0.fillContainer()
//                                }
//                                return c
//                            }
//                        }
//                        
//                        return c
//                    }
//                }
//            }
//            
//            
//            
//            for c in node.children {                
//                viewFor(renderable: c, in: theView, ignoreRefs: ignoreRefs)
//            }
//            
//            if let viewNode = node as? View {
//                if !viewNode.childrenLayout.isEmpty {
//                    var newArray:[Any] = [Any]()
//                    for a in viewNode.childrenLayout {
//                        if let c = a as? Int {
//                            newArray.append(CGFloat(c))
//                        } else if let n = a as? Node {
//                            newArray.append(viewFor(renderable: n, in: theView, ignoreRefs: ignoreRefs))
//                        } else if let array = a as? [Any] {
//                            let transformedArray:[Any] = array.map { x in
//                                if let i = x as? Int {
//                                    return CGFloat(i)
//                                } else if let n = x as? Node {
//                                    return viewFor(renderable: n, in: theView, ignoreRefs: ignoreRefs)
//                                }
//                                return ""
//                            }
//                            newArray.append(transformedArray)
//                        }
//                    }
//                    
//                    // Test verical margins
//                    var previousMargin: CGFloat?
//                    var previousView: UIView?
//                    for v in newArray {
//                        if let m = v as? CGFloat {
//                            previousMargin = m
//                        }
//                        if let av = v as? UIView {
//                            if let pv = previousView, let pm = previousMargin {
//                                theView.layout(
//                                    pv,
//                                    pm,
//                                    av
//                                )
//                                previousView = nil
//                                previousMargin = nil
//                            }
//                            
//                            if let pm = previousMargin {
//                                av.top(pm)
//                                previousMargin = nil
//                            }
//                            previousView = av
//                        }
//                        
//                        if let horizontalArray = v as? [Any] {
//                            
//                            var previousHMargin: CGFloat?
//                            var previousHView: UIView?
//                            for x in horizontalArray {
//                                
//                                if let m = x as? CGFloat {
//                                    previousHMargin = m
//                                    
//                                    if let av = previousHView {
//                                        av.right(m)
//                                    }
//                                    
//                                }
//                                if let av = x as? UIView {
//                                    if let phm = previousHMargin {
//                                        av.left(phm)
//                                    }
//                                        
//                                    //copied
//                                    if let pv = previousView, let pm = previousMargin {
//                                        theView.layout(
//                                            pv,
//                                            pm,
//                                            av
//                                        )
//                                        previousView = nil
//                                        previousMargin = nil
//                                    }
//                                    
//                                    previousHView = av
//                                }  
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        
//        // Hierarchy
//        if let theView = theView {
//            if let aComponent = renderable as? IsComponent, !(aComponent is UIViewController), !(aComponent is UIView)  {
//                let cId = aComponent.uniqueIdentifier
//                // only if not present
//                if engine.componentsMap.index(forKey: cId) == nil {
//                    engine.componentsMap[cId] = aComponent //// Retain the componenent
//                    
//                    if let parent = parentComponent {
//                        if let children = engine.componentsChildren[parent.uniqueIdentifier] {
//                            engine.componentsChildren[parent.uniqueIdentifier] = (children + [cId])
//                        } else {
//                            engine.componentsChildren[parent.uniqueIdentifier] = [cId]
//                        }
//                    }
//                }
//                engine.viewMap[cId] = theView // update view entry.
//            }
//            
//            theView.translatesAutoresizingMaskIntoConstraints = false
//            if let stackView = parentView as? UIStackView {
//                
//                if let atIndex = atIndex {
//                    stackView.insertArrangedSubview(theView, at: atIndex)
//                } else {
//                    stackView.addArrangedSubview(theView)
//                }
//            } else {
//                parentView.addSubview(theView)
//            }
//        }
//        
//        node.applyLayout?()
//        
//        testLayoutBlock()
//        
//        node.applyStyle?()
//
//        if let tfNode = node as? TextView {
//            tfNode.registerTextChanged?(theView as! UITextView)
//        }

//        return theView ?? UIView()
//    }
//}
