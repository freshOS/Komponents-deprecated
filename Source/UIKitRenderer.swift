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
    
    var storedSubComponents: [IsComponent] = [IsComponent]()
    
    func render(tree: Tree, in view: UIView) {
        storedSubComponents = [IsComponent]()
        privateRender(tree: tree, in: view)
        for sc in storedSubComponents {
            sc.didRender()
        }
    }
    
    func privateRender(tree: Tree, in view: UIView) {
        
        var tree = tree
        
        if let subComponenet = tree as? IsStatefulComponent {
            let cId = subComponenet.uniqueComponentIdentifier
            componentIdNodeIdViewMap[cId] = tree.uniqueIdentifier
            
            // Create new engine for subcompoenent
            subComponenet.reactEngine = KomponentsEngine() // link new engine

        } else if let subComponenet = tree as? Renderable {
            tree = subComponenet.render()
        }
        
        // Create a UIKIt view form a node
        let newView = viewForNode(node: tree)
    
        // Link references
        linkReference(of: tree, to: newView)
        
        nodeIdViewMap[tree.uniqueIdentifier] = newView
        
        for c in tree.children {
            
            if let subComponenet = c as? IsStatefulComponent {
                subComponenet.reactEngine = KomponentsEngine()
                subComponenet.reactEngine?.rootView = newView
                subComponenet.reactEngine?.render(component: subComponenet, in: newView)
                storedSubComponents.append(subComponenet)
            } else if let subComponenet = c as? IsComponent {
                storedSubComponents.append(subComponenet)
                privateRender(tree: c, in: newView)
            } else {
                privateRender(tree: c, in: newView)
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
        } else if let cell = view as? UITableViewCell {
            cell.contentView.addSubview(newView)
        } else {
            view.addSubview(newView)
        }
    }
}
