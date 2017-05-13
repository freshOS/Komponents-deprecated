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
    
    func render(tree:Tree, in view: UIView) {
        
        var tree = tree
        if let subComponenet = tree as? IsComponent {
            let cId = subComponenet.uniqueComponentIdentifier
            tree = subComponenet.render()
            componentIdNodeIdViewMap[cId] = tree.uniqueIdentifier
        }
        
        
        // Create a UIKIt view form a node
        let newView = viewForNode(node: tree)
    
        // Link references
        linkReference(of: tree, to: newView)
        
//        if let subComponenet = tree as? IsComponent {
////            let subTree = subComponenet.render()
////            tree = subTree
////            
//            let cId = subComponenet.uniqueComponentIdentifier
//            componentIdNodeIdViewMap[cId] = tree.uniqueIdentifier
//        }
//
//            //                render(tree: subTree, in: newView)
//        } else {
            nodeIdViewMap[tree.uniqueIdentifier] = newView // todo use same table for Compoenents?
//        }
        
        for c in tree.children {
            // replace child carrement?
            if let subComponenet = c as? IsComponent {
//                let subTree = subComponenet.render()
//                render(tree: subTree, in: newView)
                render(tree: c, in: newView)
                subComponenet.didRender()
            } else {
                render(tree: c, in: newView)
            }
        }
        
        // View Hierarchy (Use autolayout)
        add(newView, asSubviewOf: view)
        
        // Layout
        layout(newView, withLayout: tree.layout, inView: view)
        
        // Plug events
        plugEvents(from: tree, to: newView)
    }
    
    func add(_ newView: UIView, asSubviewOf view: UIView) {
        newView.translatesAutoresizingMaskIntoConstraints = false
        if let stackView = view as? UIStackView {
            stackView.addArrangedSubview(newView)
        } else {
            view.addSubview(newView)
        }
    }
    

}
