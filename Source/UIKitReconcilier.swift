//
//  UIKitReconcilier.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer & Yannick Levif on 02/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

class UIKitReconcilier {
    
    weak var engine: KomponentsEngine?
    
    var updates = [()->Void]()
    
    func mainUpdateChildren(_ oldNode: Tree, _ newNode: Tree) {
        updateChildren(oldNode, newNode)
        DispatchQueue.main.async {
            for u in self.updates {
                u()
            }
        }
    }
    
    private func updateChildren(_ oldNode: IsNode, _ newNode: IsNode) {
        let newLength = newNode.children.count
        let oldLength = oldNode.children.count
        let length = max(oldLength, newLength)
        
        var iNew = 0
        var iOld = 0
        var i = 0
        
        while i < length {
            
            var newChildNode: IsNode?
            var oldChildNode: IsNode?
            
            if iNew < newNode.children.count {
                newChildNode = newNode.children[iNew]
            }
            if iOld < oldNode.children.count {
                oldChildNode = oldNode.children[iOld]
            }
    
            let retChildNode = walk(oldChildNode, newChildNode)
            
            if retChildNode == nil { // Node removed !
                if let oldChildNode = oldChildNode {
                    if let removedView = self.engine?.renderer.nodeIdViewMap[oldChildNode.uniqueIdentifier] {
                        
                        log("💉 Removing node \(oldChildNode)")
                        updates.append {
                            removedView.removeFromSuperview() // different when its a stackview?
                        }
                    }
                    iOld -= 1
                }
            } else if oldChildNode == nil { // New Node Added
                if let retChildNode = retChildNode,
                    let parenView = self.engine?.renderer.nodeIdViewMap[newNode.uniqueIdentifier] {
                    log("💉 Adding node \(type(of: retChildNode)) (id:\(retChildNode.uniqueIdentifier) )")
                    updates.append {
                        self.engine?.renderer.render(tree: retChildNode, in: parenView)
                    }
                    iNew -= 1
                }
            } else if let retChildNode = retChildNode,
            let oldChildNode = oldChildNode, !areTreesEqual(retChildNode, oldChildNode) {
                // Replacement by non patchable node (different node type.)
                if let parenView = self.engine?.renderer.nodeIdViewMap[oldNode.uniqueIdentifier],
                    let removedView = self.engine?.renderer.nodeIdViewMap[oldChildNode.uniqueIdentifier] {
                    log("💉 Replacing node")
                    updates.append {
                        // render new node in parentView
                        self.engine?.renderer.render(tree: retChildNode, in: parenView)
                        // remove old node
                        removedView.removeFromSuperview()
                    }
//                    iNew = iNew - 1 //is this useful?
                }
            } else if let newChildNode = newChildNode, let oldChildNode = oldChildNode {
                // Recurse on Children
                updateChildren(oldChildNode, newChildNode)
            }
            
            i += 1
            iNew += 1
            iOld += 1
        }
    }
    
    private func walk(_ oldNode: IsNode?, _ newNode: IsNode?) -> IsNode? {
        if let old = oldNode {
            if let new = newNode {
                if type(of: old) == type(of: new) { // Same type nodes
                    
                    // Update IDS
                    if var map = self.engine?.renderer.nodeIdViewMap {
                        map[new.uniqueIdentifier] = map[old.uniqueIdentifier]
                        map.removeValue(forKey: old.uniqueIdentifier)
                        self.engine?.renderer.nodeIdViewMap = map
                    }
                    
                    if areTreesEqual(new, old) { // Nothing changed, keep old
                        return old
                    } else { // Somtheing is different, pathc properties and update children.
                        smash(old, new)
                        return old // Test new for ids
                    }
                } else {
                    // Replace by a diffrent node, so return new
                    return newNode
                }
            } else {
                return nil
            }
        }
        return newNode
    }
    
    func log(_ s: String) {
        if Komponents.logsEnabled {
            print(s)
        }
    }
}
