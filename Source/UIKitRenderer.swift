//
//  UIKitRenderer.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

class UIKitRenderer: Renderer {
    
    weak var engine: KomponentsEngine!
    weak var parentComponent: IsComponent?
    
    func render(_ renderable: Renderable, in rootView: UIView, withEngine: KomponentsEngine, atIndex: Int? = nil) {
        
        if rootView.superview != nil {
            if let c = renderable as? IsComponent, Komponents.logsEnabled {
                print("⚛️ Rendering \(c) : \(c.uniqueIdentifier)")
            }
        }
        
        
        engine = withEngine

        
        
        if let cell = rootView as? UITableViewCell {
            
            
            let compoenentRootView = viewFor(renderable: renderable, in:cell.contentView, atIndex: atIndex) //recursive
            
        
    
                compoenentRootView.fillContainer()
            
            
            if let c = renderable as? IsComponent {
                c.didRender()
            }
            if renderable is UIViewController || renderable is UIView {
                compoenentRootView.fillContainer()
            }
            
            if let c = renderable as? IsComponent {
                c.didRender()
            }
        } else {
            let compoenentRootView = viewFor(renderable: renderable, in:rootView, atIndex: atIndex) //recursive
            
            if renderable is UIViewController || renderable is UIView {
                compoenentRootView.fillContainer()
            }
            
            if let c = renderable as? IsComponent {
                c.didRender()
            }
        }
    }
    
    @discardableResult
    func viewFor(renderable: Renderable, in parentView: UIView, atIndex: Int? = nil) -> UIView {
        
        // Store Parent component to associated it with its future children.
        if let c = renderable as? IsComponent, c is UIViewController || c is UIView {
            parentComponent = c
        }
    
        var theView: UIView?
        var node = renderable.render()
        
        if let viewNode = node as? View {
            let v = UIView()
            theView = v
            node.applyLayout = {
                viewNode.layoutBlock?(v)
            }
            node.applyStyle = {
                viewNode.styleBlock?(v)
            }
            viewNode.ref?.pointee = v
        }
        
        if let vStackNode = node as? VerticalStack {
            let stack = UIStackView()
            stack.axis = .vertical
            theView = stack
            print(vStackNode)
            node.applyLayout = {
                vStackNode.layoutBlock?(stack)
            }
            node.applyStyle = {
                vStackNode.styleBlock?(stack)
            }
        }
        
        if let hStackNode = node as? HorizontalStack {
            let stack = UIStackView()
            stack.axis = .horizontal
            theView = stack
            node.applyLayout = {
                hStackNode.layoutBlock?(stack)
            }
            node.applyStyle = {
                hStackNode.styleBlock?(stack)
            }
        }
        
        if let textNode = node as? Label {
            let label = UILabel()
            label.text = textNode.wording
            theView = label
            node.applyLayout = {
                textNode.layoutBlock?(label)
            }
            node.applyStyle = {
                textNode.styleBlock?(label)
            }
            textNode.ref?.pointee = label
        }
        
        if let fieldNode = node as? Field {
            let field = BlockBasedUITextField()
            field.placeholder = fieldNode.placeholder
            field.text  = fieldNode.wording
            theView = field
            node.applyLayout = {
                fieldNode.layoutBlock?(field)
            }
            node.applyStyle = {
                fieldNode.styleBlock?(field)
            }
            fieldNode.ref?.pointee = field
        }
        
        if let textViewNode = node as? TextView {
            let textView = BlockBasedUITextView()
            textView.text  = textViewNode.wording
            theView = textView
            node.applyLayout = {
                textViewNode.layoutBlock?(textView)
            }
            node.applyStyle = {
                textViewNode.styleBlock?(textView)
            }
            textViewNode.ref?.pointee = textView
        }
        
        if let buttonNode = node as? Button {
            let button = BlockBasedUIButton()
            button.setTitle(buttonNode.wording, for: .normal)
            if let img = buttonNode.image {
                button.setImage(img, for: .normal)
            }
            theView = button
            node.applyLayout = {
                buttonNode.layoutBlock?(button)
            }
            node.applyStyle = {
                buttonNode.styleBlock?(button)
            }
            buttonNode.ref?.pointee = button
        }
        
        if let imageNode = node as? Image {
            let v = UIImageView()
            theView = v
            node.applyLayout = {
                imageNode.layoutBlock?(v)
            }
            node.applyStyle = {
                imageNode.styleBlock?(v)
            }
            imageNode.ref?.pointee = v
            v.image = imageNode.image
        }
        
        if let scrollViewNode = node as? ScrollView {
            let v = UIScrollView()
            theView = v
            node.applyLayout = {
                scrollViewNode.layoutBlock?(v)
            }
            node.applyStyle = {
                scrollViewNode.styleBlock?(v)
            }
            scrollViewNode.ref?.pointee = v
        }
        
        if let pageControlNode = node as? PageControl {
            let v = UIPageControl()
            theView = v
            node.applyLayout = {
                pageControlNode.layoutBlock?(v)
            }
            node.applyStyle = {
                pageControlNode.styleBlock?(v)
            }
            pageControlNode.ref?.pointee = v
        }
        
        if let spinnerNode = node as? ActivityIndicatorView {
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: spinnerNode.activityIndicatorStyle)
            theView = spinner
            node.applyLayout = {
                spinnerNode.layoutBlock?(spinner)
            }
            node.applyStyle = {
                spinnerNode.styleBlock?(spinner)
            }
            spinnerNode.ref?.pointee = spinner
            
            spinner.startAnimating()
        }
        
        if let sliderNode = node as? Slider {
            let slider = BlockBasedUISlider()
            slider.value = sliderNode.value
            theView = slider
            node.applyLayout = {
                sliderNode.layoutBlock?(slider)
            }
            node.applyStyle = {
                sliderNode.styleBlock?(slider)
            }
            sliderNode.ref?.pointee = slider
        }
        
        if let switchNode = node as? Switch {
            let aSwitch = BlockBasedUISwitch()
            aSwitch.isOn = switchNode.isOn
            theView = aSwitch
            node.applyLayout = {
                switchNode.layoutBlock?(aSwitch)
            }
            node.applyStyle = {
                switchNode.styleBlock?(aSwitch)
            }
            switchNode.ref?.pointee = aSwitch
        }
        
        if let progressNode = node as? Progress {
            let progress = UIProgressView()
            progress.progress = progressNode.progress
            theView = progress
            node.applyLayout = {
                progressNode.layoutBlock?(progress)
            }
            node.applyStyle = {
                progressNode.styleBlock?(progress)
            }
            progressNode.ref?.pointee = progress
        }
        
        if var tableNode = node as? Table {
            let table = CallBackTableView(frame: CGRect.zero, style: tableNode.tableStyle)
            table.estimatedRowHeight = 100
            
            if let rc = tableNode.refreshCallback {
                let refreshControl = BlockBasedUIRefreshControl()
                table.addSubview(refreshControl)
                refreshControl.setCallback(rc)
            }
            
            table.numberOfRows = {
                return tableNode.cells.count
            }
            table.cellForRowAt = { tbv, ip in
                if ip.section == 0 {
                    let child = tableNode.cells[ip.row]
                    return ComponentCell(component: child)
                }
                return UITableViewCell()
            }
            
            
            if let deleteCallback = tableNode.deleteCallback {
                table.didDeleteRowAt = { ip in
                    let shouldDeleteBlock = { (b:Bool) in
                        if b {
                            // Remove cell
                            tableNode.cells.remove(at: ip.row)
                            // Delete corresponding row.
                            table.deleteRows(at: [ip], with: .none)
                        } else {
                            table.reloadRows(at: [ip], with: .none)
                        }
                    }
                    deleteCallback(ip.row, shouldDeleteBlock)
                }
            }
            
            theView = table
            node.applyLayout = {
                tableNode.layoutBlock?(table)
            }
            node.applyStyle = {
                tableNode.styleBlock?(table)
            }
            tableNode.ref?.pointee = table
        }
        
        let testLayoutBlock = { }
        
        if let theView = theView {
            
            
            // Single node inside View: use fillContainer as default layout.
            if node is View {
                if node.children.count == 1 {
                    if var singleChild = node.children[0] as? VerticalStack {
                        if singleChild.layoutBlock == nil {
                            singleChild.layoutBlock = {
                                $0.fillContainer()
                            }
                            node.children[0] = singleChild
                        }
                    }
                    
                }
            }
            
            
            
            for c in node.children {                
                viewFor(renderable: c, in: theView)
            }
            
            if let viewNode = node as? View {
                if !viewNode.childrenLayout.isEmpty {
                    var newArray:[Any] = [Any]()
                    for a in viewNode.childrenLayout {
                        if let c = a as? Int {
                            newArray.append(CGFloat(c))
                        } else if let n = a as? Node {
                            newArray.append(viewFor(renderable: n, in: theView))
                        } else if let array = a as? [Any] {
                            let transformedArray:[Any] = array.map { x in
                                if let i = x as? Int {
                                    return CGFloat(i)
                                } else if let n = x as? Node {
                                    return viewFor(renderable: n, in: theView)
                                }
                                return ""
                            }
                            newArray.append(transformedArray)
                        }
                    }
                    
                    // Test verical margins
                    var previousMargin: CGFloat?
                    var previousView: UIView?
                    for v in newArray {
                        if let m = v as? CGFloat {
                            previousMargin = m
                        }
                        if let av = v as? UIView {
                            if let pv = previousView, let pm = previousMargin {
                                theView.layout(
                                    pv,
                                    pm,
                                    av
                                )
                                previousView = nil
                                previousMargin = nil
                            }
                            
                            if let pm = previousMargin {
                                av.top(pm)
                                previousMargin = nil
                            }
                            previousView = av
                        }
                        
                        if let horizontalArray = v as? [Any] {
                            
                            var previousHMargin: CGFloat?
                            var previousHView: UIView?
                            for x in horizontalArray {
                                
                                if let m = x as? CGFloat {
                                    previousHMargin = m
                                    
                                    if let av = previousHView {
                                        av.right(m)
                                    }
                                    
                                }
                                if let av = x as? UIView {
                                    if let phm = previousHMargin {
                                        av.left(phm)
                                    }
                                        
                                    //copied
                                    if let pv = previousView, let pm = previousMargin {
                                        theView.layout(
                                            pv,
                                            pm,
                                            av
                                        )
                                        previousView = nil
                                        previousMargin = nil
                                    }
                                    
                                    previousHView = av
                                }  
                            }
                        }
                    }
                }
            }
        }
        
        // Hierarchy
        if let theView = theView {
            if let aComponent = renderable as? IsComponent, !(aComponent is UIViewController), !(aComponent is UIView)  {
                let cId = aComponent.uniqueIdentifier
                // only if not present
                if engine.componentsMap.index(forKey: cId) == nil {
                    engine.componentsMap[cId] = aComponent //// Retain the componenent
                    
                    if let parent = parentComponent {
                        if let children = engine.componentsChildren[parent.uniqueIdentifier] {
                            engine.componentsChildren[parent.uniqueIdentifier] = (children + [cId])
                        } else {
                            engine.componentsChildren[parent.uniqueIdentifier] = [cId]
                        }
                    }
                }
                engine.viewMap[cId] = theView // update view entry.
            }
            
            theView.translatesAutoresizingMaskIntoConstraints = false
            if let stackView = parentView as? UIStackView {
                
                if let atIndex = atIndex {
                    stackView.insertArrangedSubview(theView, at: atIndex)
                } else {
                    stackView.addArrangedSubview(theView)
                }
            } else {
                parentView.addSubview(theView)
            }
        }
        
        node.applyLayout?()
        
        testLayoutBlock()
        
        node.applyStyle?()
        
        //Register taps ?? need to be at the end ? after adding to view Hierarchy?
        if let bNode = node as? Button {
            bNode.registerTap?(theView as! UIButton)
        }
        
        if let tfNode = node as? Field {
            tfNode.registerTextChanged?(theView as! UITextField)
            if tfNode.isFocused {
            }
        }
        
        if let tfNode = node as? TextView {
            tfNode.registerTextChanged?(theView as! UITextView)
        }
        
        if let sliderNode = node as? Slider {
            sliderNode.registerValueChanged?(theView as! UISlider)
        }
        
        if let switchNode = node as? Switch {
            switchNode.registerValueChanged?(theView as! UISwitch)
        }
        
        return theView ?? UIView()
    }
}
