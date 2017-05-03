//
//  UIKitReconcilier.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 02/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

class UIKitReconcilier {
    
    var updates = [()->Void]()
    
    func walk (_ oldNode: UIView?, _ newNode: UIView?) -> UIView? {
        if let old = oldNode {
            if let new = newNode {
                if (new == old) {
                    return old
                } else {
                    smash(old, new)
                    updateChildren(old, new)
                    return old
                }
            } else {
                return nil
            }
        } else {
            return newNode
        }
        
    }
    
    func smash(_ oldNode: UIView, _ newNode: UIView) {
        // read each node attributes and diff them
        // then patch the old node (side-effect)
        // - layout
        // - events
        
        
        // Label
        if let label = oldNode as? UILabel, let newLabel = newNode as? UILabel {
            if newLabel.text != label.text {
                
                updates.append {
                    label.text = newLabel.text
                }
                print("💉 Patch text")
            }
            
            if newLabel.textColor != label.textColor {
                updates.append {
                    label.textColor = newLabel.textColor
                }
                print("💉 Patch textColor")
            }
        }
        
        
        // Button
        if let button = oldNode as? UIButton, let newButton = newNode as? UIButton {
            
            
            if newButton.backgroundImage(for: .normal) != button.backgroundImage(for: .normal) {
                
                let img = newButton.backgroundImage(for: .normal)
                updates.append {
                    button.setBackgroundImage(img, for: .normal)
                }
                print("💉 Patch backgroundImage")
            }
        }
    }
    
    func mainUpdateChildren(_ oldNode: UIView, _ newNode: UIView) {
        updateChildren(oldNode, newNode)
        DispatchQueue.main.async {
            for u in self.updates {
                u()
            }
        }
    }
    
    private func updateChildren(_ oldNode: UIView, _ newNode: UIView) {
        let newLength = newNode.subviews.count
        let oldLength = oldNode.subviews.count
        let length = max(oldLength, newLength)
        
        var iNew = 0
        var iOld = 0
        var i = 0
        
        while i < length {
            
            
            var newChildNode: UIView?
            var oldChildNode: UIView?
            if iNew < newNode.subviews.count {
                newChildNode = newNode.subviews[iNew]
            }
            if iOld < oldNode.subviews.count {
                oldChildNode = oldNode.subviews[iOld]
            }
            
            let retChildNode = walk(oldChildNode, newChildNode)
            
            // TODO Add remove nodes if hierarchy changed
            //            if (retChildNode == nil) {
            //                if (oldChildNode != nil) {
            //                    oldNode.subviews.remove(at: i)
            //                    iOld = iOld-1
            //                }
            //            } else if (oldChildNode == nil) {
            //                if (retChildNode) {
            //                    oldNode.subviews.append(retChildNode)
            //                    iNew = iNew- 1
            //                }
            //            } else if (retChildNode != oldChildNode) {
            //                oldNode.subviews.remove(at: i)
            //                oldNode.subviews.insert(retChildNode, at: i)
            //                iNew = iNew- 1
            //            }
            
            i = i+1
            iNew = iNew+1
            iOld = iOld+1
        }
    }
}
