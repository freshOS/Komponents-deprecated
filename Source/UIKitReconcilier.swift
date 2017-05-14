//
//  UIKitReconcilier.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer & Yannick Levif on 02/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

class UIKitReconcilier {
    
    weak var engine:KomponentsEngine?
    
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
                    if let removedView = self.engine?.renderer.nodeIdViewMap[oldChildNode.uniqueIdentifier]  {
                        updates.append {
                            removedView.removeFromSuperview() // different when its a stackview?
                        }
                    }
                    iOld = iOld-1
                }
            } else if oldChildNode == nil { // New Node Added
                if let retChildNode = retChildNode, let parenView = self.engine?.renderer.nodeIdViewMap[oldNode.uniqueIdentifier]  {
                    updates.append {
                        self.engine?.renderer.render(tree: retChildNode, in: parenView)
                    }
                    iNew = iNew - 1
                }
            } else { // Replacement by non patchable node (different node type.)
                if let retChildNode = retChildNode, let oldChildNode = oldChildNode,
                    let parenView = self.engine?.renderer.nodeIdViewMap[oldNode.uniqueIdentifier],
                    let removedView = self.engine?.renderer.nodeIdViewMap[oldChildNode.uniqueIdentifier]  {
                    updates.append {
                        // render new node in parentView
                        self.engine?.renderer.render(tree: retChildNode, in: parenView)
                        // remove old node
                        removedView.removeFromSuperview()
                    }
                    iNew = iNew - 1 //is this useful?
                }
            }
            
            i = i+1
            iNew = iNew+1
            iOld = iOld+1
        }
    }
    
    private func walk(_ oldNode: IsNode?, _ newNode: IsNode?) -> IsNode? {
        if let old = oldNode {
            if let new = newNode {
                if type(of: old) == type(of: new) { // Same type nodes
                    if areTreesEqual(new, old) { // Nothing changed, keep old
                        return old
                    } else { // Somtheing is different, pathc properties and update children.
                        smash(old, new)
                        updateChildren(old, new)
                        return old
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
    
    func log(_ s:String) {
        if Komponents.logsEnabled {
            print(s)
        }
    }
    
    private func smash(_ oldNode: IsNode, _ newNode: IsNode) {
        // read each node attributes and diff them
        // then patch the old node (side-effect)
        // - layout
        // - events
        
        // View
        if let view = oldNode as? View, let newView = newNode as? View {
            if newView.props.backgroundColor != view.props.backgroundColor {
                if let uiView = engine?.renderer.nodeIdViewMap[view.uniqueIdentifier] {
                    updates.append {
                        uiView.backgroundColor = newView.props.backgroundColor
                    }
                    log("💉 Patch BackgroundColor")
                }
            }
        }
//
//        if newNode.isHidden != oldNode.isHidden {
//            let c = newNode.isHidden
//            updates.append {
//                oldNode.isHidden = c
//            }
//            log("💉 Patch isHidden")
//        }
//        
//        if newNode.alpha != oldNode.alpha {
//            let c = newNode.alpha
//            updates.append {
//                oldNode.alpha = c
//            }
//            log("💉 Patch alpha")
//        }
//        
        
        // Label
        if let label = oldNode as? Label, let newLabel = newNode as? Label {
            if newLabel.props.text != label.props.text {
                if let uiLabel = engine?.renderer.nodeIdViewMap[label.uniqueIdentifier] as? UILabel {
                    log("💉 Patch text")
                    updates.append {
                        uiLabel.text = newLabel.props.text
                    }
                }
            }
            
//            if newLabel.textColor != label.textColor {
//                updates.append {
//                    label.textColor = newLabel.textColor
//                }
//                log("💉 Patch textColor")
//            }
        }
        
        
//        // Button
//        if let button = oldNode as? UIButton, let newButton = newNode as? UIButton {
//            if newButton.backgroundImage(for: .normal) != button.backgroundImage(for: .normal) {
//                let img = newButton.backgroundImage(for: .normal)
//                updates.append {
//                    button.setBackgroundImage(img, for: .normal)
//                }
//                log("💉 Patch backgroundImage")
//            }
//            
//            if newButton.title(for: .normal) != button.title(for: .normal) {
//                let text = newButton.title(for: .normal)
//                updates.append {
//                    button.setTitle(text, for: .normal)
//                }
//                log("💉 Patch Title")
//            }
//            
//            if newButton.isEnabled != button.isEnabled {
//                let e = newButton.isEnabled
//                updates.append {
//                    button.isEnabled = e
//                }
//                log("💉 Patch isEnabled")
//            }
//        }
//        
//        
//        // Image
//        if let image = oldNode as? UIImageView, let newImage = newNode as? UIImageView {
//            if newImage.image != image.image {
//                let img = newImage.image
//                updates.append {
//                    image.image = img
//                }
//                log("💉 Patch Image")
//            }
//        }
//        
//        
//        // Switch
//        if let oldSwitch = oldNode as? UISwitch, let newSwitch = newNode as? UISwitch {
//            if newSwitch.isOn != oldSwitch.isOn {
//                updates.append {
//                    oldSwitch.isOn = newSwitch.isOn
//                }
//                log("💉 Patch isON")
//            }
//            
//        }
    }

}
