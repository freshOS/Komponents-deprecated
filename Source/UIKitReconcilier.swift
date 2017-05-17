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
                        print("💉 Removing node \(oldChildNode)")
                        updates.append {
                            removedView.removeFromSuperview() // different when its a stackview?
                        }
                    }
                    iOld -= 1
                }
            } else if oldChildNode == nil { // New Node Added
                if let retChildNode = retChildNode,
                    let parenView = self.engine?.renderer.nodeIdViewMap[oldNode.uniqueIdentifier] {
                    print("💉 Adding node \(type(of: retChildNode)) (id:\(retChildNode.uniqueIdentifier) )")
                    updates.append {
                        self.engine?.renderer.render(tree: retChildNode, in: parenView)
                    }
                    iNew -= 1
                }
            } else if !areTreesEqual(retChildNode!, oldChildNode!) {
                // Replacement by non patchable node (different node type.)
                if let retChildNode = retChildNode, let oldChildNode = oldChildNode,
                    let parenView = self.engine?.renderer.nodeIdViewMap[oldNode.uniqueIdentifier],
                    let removedView = self.engine?.renderer.nodeIdViewMap[oldChildNode.uniqueIdentifier] {
                    print("💉 Replacing node")
                    updates.append {
                        // render new node in parentView
                        self.engine?.renderer.render(tree: retChildNode, in: parenView)
                        // remove old node
                        removedView.removeFromSuperview()
                    }
//                    iNew = iNew - 1 //is this useful?
                }
            } else {
                // Recurse on Children
                updateChildren(oldChildNode!, newChildNode!)
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
//                        updateChildren(old, new)
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
    
    private func smash(_ oldNode: IsNode, _ newNode: IsNode) {
            
        // Patch Layout
        if newNode.layout != oldNode.layout {
            if let uiView = engine?.renderer.nodeIdViewMap[newNode.uniqueIdentifier] {
                log("💉 Patch Layout")
                updates.append {
                    // remove all previous layout constraints
                    uiView.removeConstraints(uiView.constraints)
                    
                    // Apply new layout
                    layout(uiView, withLayout: newNode.layout, inView: uiView.superview!)
                }
            }
        }
        
        // View
        if let view = oldNode as? View, let newView = newNode as? View {
            if newView.props.backgroundColor != view.props.backgroundColor {
                if let uiView = engine?.renderer.nodeIdViewMap[newView.uniqueIdentifier] {
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
                if let uiLabel = engine?.renderer.nodeIdViewMap[newLabel.uniqueIdentifier] as? UILabel {
                    log("💉 Patch text")
                    updates.append {
                        uiLabel.text = newLabel.props.text
                    }
                    
                    // Update NodeID - View Map
                    
                }
            }
            
//            if newLabel.textColor != label.textColor {
//                updates.append {
//                    label.textColor = newLabel.textColor
//                }
//                log("💉 Patch textColor")
//            }
        }
        
        // Button
        if let button = oldNode as? Button, let newButton = newNode as? Button {
            if newButton.props.image != button.props.image {
                if let uibutton = engine?.renderer.nodeIdViewMap[newButton.uniqueIdentifier] as? UIButton {
                    log("💉 Patch image")
                    updates.append {
                        uibutton.setImage(newButton.props.image, for: .normal)
                    }
                }
            }
            
            // isEnabled
            if newButton.props.isEnabled != button.props.isEnabled {
                if let uibutton = engine?.renderer.nodeIdViewMap[newButton.uniqueIdentifier] as? UIButton {
                    log("💉 Patch isEnabled")
                    updates.append {
                        uibutton.isEnabled = newButton.props.isEnabled
                    }
                }
            }
            
            // BackgroudnColor
            if newButton.props.backgroundColorForNormalState != button.props.backgroundColorForNormalState {
                if let uibutton = engine?.renderer.nodeIdViewMap[newButton.uniqueIdentifier] as? BlockBasedUIButton {
                    log("💉 Patch backgroudnColor")
                    updates.append {
                        uibutton.setBackgroundColor(newButton.props.backgroundColorForNormalState, for: .normal)
                    }
                }
            }
        }
        
        // Image
        if let image = oldNode as? Image, let newImage = newNode as? Image {
            if newImage.props.image != image.props.image {
                if let uiimage = engine?.renderer.nodeIdViewMap[newImage.uniqueIdentifier] as? UIImageView {
                    log("💉 Patch image")
                    updates.append {
                        uiimage.image = newImage.props.image
                    }
                }
            }
        }
        
        // ActivityIndicatorView
        if let spinner = oldNode as? ActivityIndicatorView, let newSpinner = newNode as? ActivityIndicatorView {
            if newSpinner.props.isHidden != spinner.props.isHidden {
                if let uiSpinner = engine?.renderer.nodeIdViewMap[newSpinner.uniqueIdentifier] as? UIActivityIndicatorView {
                    log("💉 Patch isHidden")
                    updates.append {
                        if newSpinner.props.isHidden {
                            uiSpinner.stopAnimating()
                        } else {
                            uiSpinner.startAnimating()
                        }
                    }
                }
            }
        }
        
        // Field
        if let field = oldNode as? Field, let newField = newNode as? Field {
            if newField.props.text != field.props.text {
                if let uitextField = engine?.renderer.nodeIdViewMap[newField.uniqueIdentifier] as? UITextField {
                    log("💉 Patch text")
                    updates.append {
                        uitextField.text = newField.props.text
                    }
                    
                    // Update NodeID - View Map
                    
                }
            }
            
            //            if newLabel.textColor != label.textColor {
            //                updates.append {
            //                    label.textColor = newLabel.textColor
            //                }
            //                log("💉 Patch textColor")
            //            }
        }
        
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
//
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
