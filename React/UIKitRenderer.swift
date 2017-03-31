//
//  UIKitRenderer.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit


class UIKitRenderer: Renderer {
    
    
    func render(_ renderable: Renderable, in rootView: UIView) {
        viewFor(renderable: renderable, in:rootView) //recursive
    }


    @discardableResult
    func viewFor(renderable: Renderable, in parentView:UIView) -> UIView {
        
        var theView:UIView?
        
        
        
        
//        let comp = renderable as! Component 
        
//            return viewFor(component: comp, in: parentView)
//         
//        }
        print(renderable)
        
        if var node = renderable as? Node {
            
    
            if let viewNode = node as? View {
                let v = UIView()
                theView = v
                node.applyLayout = {
                    viewNode.layoutBlock?(v)
                }
                node.applyStyle = {
                    viewNode.styleBlock?(v)
                }
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
            
            //        if let vStack = node as? VerticalStack {
            //            let stack = UIStackView()
            //            stack.axis = .vertical
            //            vStack.styleBlock?(stack)
            
            
            if let textNode = node as? Text {
                let label = UILabel()
                label.text = textNode.wording
                theView = label
                node.applyLayout = {
                    textNode.layoutBlock?(label)
                }
                node.applyStyle = {
                    textNode.styleBlock?(label)
                }
            }
            
            if let buttonNode = node as? Button {
                let button = UIButton()
                button.setTitle(buttonNode.wording, for: .normal)
                button.setTitleColor(.red, for: .normal)
                button.setTitleColor(.blue, for: .highlighted)
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
            }
            
            if let theView = theView {
                for c in node.children {
                    viewFor(renderable: c, in: theView)
                }
            }
            
            // style??
            // layout??
                
    //            view.styleBlock?(v)
    //            
    //            for c in view.children {
    //                viewFor(node: c, in: v)
    //                
    ////                let childView = viewFor(node: c)
    ////                
    ////                stack.addArrangedSubview(childView)
    ////                c.aStyle?()
    ////                
    ////                
    ////                if let bNode = c as? Button {
    ////                    bNode.registerTap?(childView as! UIButton)
    ////                }
    //                
    //            }
    ////            parentView.addSubview(stack)
    ////            view.layoutBlock?(stack)
    //        }
            
            
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
            node.applyStyle?()
            
            //Register taps ?? need to be at the end ? after adding to view Hierarchy?
            if let bNode = node as? Button {
                bNode.registerTap?(theView as! UIButton)
            }
        
        }
        
        return theView ?? UIView()
        
    }
}

        
//        
//
//        if let vStack = node as? VerticalStack {
//            let stack = UIStackView()
//            stack.axis = .vertical
//            vStack.styleBlock?(stack)
//            stack.translatesAutoresizingMaskIntoConstraints = false
//            for c in vStack.children {
//                let childView = viewFor(node: c)
//                childView.translatesAutoresizingMaskIntoConstraints = false
//                stack.addArrangedSubview(childView)
//                c.aStyle?()
//                
//                
//                if let bNode = c as? Button {
//                    bNode.registerTap?(childView as! UIButton)
//                }
//                
//                
//            }
//            parentView.addSubview(stack)
//            vStack.layoutBlock?(stack)
//        }
//        
//        
//        
//        if let vStack = node as? VerticalStack {
//            let stack = UIStackView()
//            stack.axis = .vertical
//            vStack.styleBlock?(stack)
//            stack.translatesAutoresizingMaskIntoConstraints = false
//            for c in vStack.children {
//                let childView = viewFor(node: c)
//                childView.translatesAutoresizingMaskIntoConstraints = false
//                stack.addArrangedSubview(childView)
//                c.aStyle?()
//                
//                
//                if let bNode = c as? Button {
//                    bNode.registerTap?(childView as! UIButton)
//                }
//    
//                
//            }
//            parentView.addSubview(stack)
//            vStack.layoutBlock?(stack)
//        }
//        
//        if let hStack = node as? HorizontalStack {
//            let stack = UIStackView()
//            stack.axis = .horizontal
//            hStack.styleBlock?(stack)
//            stack.translatesAutoresizingMaskIntoConstraints = false
//            for c in hStack.children {
//                let childView = viewFor(node: c)
//                childView.translatesAutoresizingMaskIntoConstraints = false
//                stack.addArrangedSubview(childView)
//                c.aStyle?()
//                
//                
//                if let bNode = c as? Button {
//                    bNode.registerTap?(childView as! UIButton)
//                }
//                
//            }
//            parentView.addSubview(stack)
//            hStack.layoutBlock?(stack)
//        }
//        
//        
//        if let view = node as? View {
//            let v = UIView()
//            v.backgroundColor = .yellow
//            view.styleBlock?(v)
//            v.translatesAutoresizingMaskIntoConstraints = false
//            for c in view.children {
//                
//                let subv = viewFor(node: c)
//                
//                let childView = viewFor(node: c)
//                childView.translatesAutoresizingMaskIntoConstraints = false
//                stack.addArrangedSubview(childView)
//                c.aStyle?()
//                
//                
//                if let bNode = c as? Button {
//                    bNode.registerTap?(childView as! UIButton)
//                }
//                
//            }
//            parentView.addSubview(stack)
//            view.layoutBlock?(stack)
//        }
//        
//        
//        
//        
//        
//        
//        //    if let textNode = node as? TextNode {
//        //        let label = UILabel()
//        //        label.text = textNode.wording
//        //        textNode.styleBlock?(label)
//        //        label.translatesAutoresizingMaskIntoConstraints = false
//        //
//        //        textNode.layoutBlock?(label)
//        //        return label
//        //    }
//        
//
//
//        
//        if node is VerticalStack {
//            let stack = UIStackView()
//            stack.axis = .vertical
//        }
//        if var textNode = node as? Text {
//            let label = UILabel()
//            label.text = textNode.wording
//            
//            textNode.aStyle = {
//                textNode.styleBlock?(label)
//            }
//            return label
//        }
//        
//        if var buttonNode = node as? Button {
//            let button = UIButton()
//            button.setTitle(buttonNode.wording, for: .normal)
//            button.setTitleColor(.red, for: .normal)
//            button.setTitleColor(.blue, for: .highlighted)
//            
//            if let img = buttonNode.image {
//                button.setImage(img, for: .normal)
//            }
//            
////            button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
////
////            textNode.aStyle = {
////                textNode.styleBlock?(label)
////            }
//            return button
//        }
//        
//        return UIView()
//    }
