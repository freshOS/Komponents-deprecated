//
//  UIKitRenderer.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit

class UIKitRenderer: Renderer {
    
    func render(nodeView: IsNodeView) {
        let node = nodeView.render()
        if let rootView = nodeView as? UIView {
            for c in node.children {
                render(c, in: rootView)
            }
            
            if let viewNode = node as? View {
                
                let childern:[Node] = viewNode.childrenLayout.map { $0 as? Node }.flatMap{ $0 }
                for c in childern {
                    render(c, in: rootView)
                }
                
                // call the  layout block on the top view object
                viewNode.styleBlock?(rootView)
                nodeView.layoutPass()
                nodeView.didRender()
                
                
            }
            
        }
    }
    
    func render<T:IsPropsView>(nodeView: T) {
        let node = nodeView.render(props: nodeView.props)
        if let rootView = nodeView as? UIView {
            for c in node.children {
                render(c, in: rootView)
            }
            
            if let viewNode = node as? View {
                
                let childern:[Node] = viewNode.childrenLayout.map { $0 as? Node }.flatMap{ $0 }
                for c in childern {
                    render(c, in: rootView)
                }
                
                // call the  layout block on the top view object
                viewNode.styleBlock?(rootView)
                nodeView.layoutPass()
                nodeView.didRender()
            }
        }
    }
    
    func render(_ renderable: Renderable, in rootView: UIView) {
        viewFor(renderable: renderable, in:rootView) //recursive
    }
    
    @discardableResult
    func viewFor(renderable: Renderable, in parentView:UIView) -> UIView {
        var theView:UIView?
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
            let field = UITextField()
            field.placeholder = fieldNode.placeholder
            field.text  = fieldNode.wording
            theView = field
            node.applyLayout = {
                fieldNode.layoutBlock?(field)
            }
            node.applyStyle = {
                fieldNode.styleBlock?(field)
            }
        }
        
        if let buttonNode = node as? Button {
            let button = UIButton()
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
        }
        
        var testLayoutBlock = { }
        
        if let theView = theView {
            for c in node.children {
                viewFor(renderable: c, in: theView)
            }
            
            if let viewNode = node as? View {
                //                    for a in viewNode.childrenLayout {
                //                        print(a)
                //
                //
                //
                //                        if let c = a as? CGFloat {
                //                            print(c)
                //                        }
                //                    }
                
                
                if !viewNode.childrenLayout.isEmpty {
                    var newArray:[Any] = [Any]()
                    for a in viewNode.childrenLayout {
                        if let c = a as? Int {
                            newArray.append(CGFloat(c))
                        } else if let n = a as? Node {
                            newArray.append(viewFor(renderable: n, in: theView))
                        } else if let array = a as? [Any] {
                            //                                for value in array {
                            //                                    if let n = value as? Node {
                            //                                        newArray.append(viewFor(renderable: n, in: theView))
                            //                                    }
                            //                                }
                            
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
                            
                            if let pv = previousView, let pm = previousMargin   {
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
                            //                            print(av)
                            //                            print(av.superview)
                            //                                av.bottom(200)
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
                                    if let pv = previousView, let pm = previousMargin   {
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
                    
                    //                        theView.layout(newArray)
                    
                    //                        testLayoutBlock = {
                    ////                            theView.layout(newArray)
                    //
                    //                            for v in newArray {
                    //                                if let av = v as? UIView {
                    //                                    av.bottom(100)
                    ////                                    print(av.superview)
                    //                                }
                    //                            }
                    //                        }
                }
            }
        }
        
        // Hierarchy
        if let theView = theView {
            theView.translatesAutoresizingMaskIntoConstraints = false
            if let stackView = parentView as? UIStackView {
                stackView.addArrangedSubview(theView)
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
                //                    (theView as! UITextField).becomeFirstResponder()
            }
        }
        return theView ?? UIView()
    }
}
