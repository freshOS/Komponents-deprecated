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
