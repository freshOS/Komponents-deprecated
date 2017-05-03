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
        
        // Image
        if let view = oldNode as? UIView, let newView = newNode as? UIView {
            if newView.backgroundColor != view.backgroundColor {
                let c = newView.backgroundColor
                updates.append {
                    view.backgroundColor = c
                }
                print("💉 Patch BackgroundColor")
            }
        }
        
        
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
            
            if newButton.title(for: .normal) != button.title(for: .normal) {
                let text = newButton.title(for: .normal)
                updates.append {
                    button.setTitle(text, for: .normal)
                }
                print("💉 Patch Title")
            }
            
            if newButton.isEnabled != button.isEnabled {
                let e = newButton.isEnabled
                updates.append {
                    button.isEnabled = e
                }
                print("💉 Patch isEnabled")
            }
        }
        
        
        // Image
        if let image = oldNode as? UIImageView, let newImage = newNode as? UIImageView {
            if newImage.image != image.image {
                let img = newImage.image
                updates.append {
                    image.image = img
                }
                print("💉 Patch Image")
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
        let newLength = (newNode is UIStackView) ? (newNode as! UIStackView).arrangedSubviews.count : newNode.subviews.count
        let oldLength = (oldNode is UIStackView) ? (oldNode as! UIStackView).arrangedSubviews.count : oldNode.subviews.count
        let length = max(oldLength, newLength)
        
        var iNew = 0
        var iOld = 0
        var i = 0
        
        while i < length {
            
            var newChildNode: UIView?
            var oldChildNode: UIView?
            
            if let newNode = newNode as? UIStackView {
                if iNew < newNode.arrangedSubviews.count {
                    newChildNode = newNode.arrangedSubviews[iNew]
                }
            } else {
                if iNew < newNode.subviews.count {
                    newChildNode = newNode.subviews[iNew]
                }
            }
            
            if let oldNode = oldNode as? UIStackView {
                if iOld < oldNode.arrangedSubviews.count {
                    oldChildNode = oldNode.arrangedSubviews[iOld]
                }
            } else {
                if iOld < oldNode.subviews.count {
                    oldChildNode = oldNode.subviews[iOld]
                }
            }
            
            let retChildNode = walk(oldChildNode, newChildNode)
            
             //TODO Add remove nodes if hierarchy changed
            if (retChildNode == nil) { // Node removed !
                if (oldChildNode != nil) {
//                    // TODO make it work :
//                    updates.append {
//                        if let oldNode = oldNode as? UIStackView {
//                            let v = oldNode.arrangedSubviews[i]
//                            oldNode.removeArrangedSubview(v)
//                        } else {
//                            let v = oldNode.subviews[i]
//                            v.removeFromSuperview()
//                        }
//                    }
                    
                    iOld = iOld-1
                }
            } else if (oldChildNode == nil) { // New Node Added
                if let retChildNode = retChildNode {
                    updates.append {
                        if let oldNode = oldNode as? UIStackView {
                            oldNode.addArrangedSubview(retChildNode)
                        } else {
                            oldNode.addSubview(retChildNode)
                        }
                    }
                    iNew = iNew - 1
                }
            } else if (retChildNode != oldChildNode) {
//                oldNode.subviews.remove(at: i)
//                let v = oldNode.subviews[i]
//                v.removeFromSuperview()
////                oldNode.subviews.insert(retChildNode, at: i)
//                oldNode.insertSubview(retChildNode, at: i)
//                iNew = iNew - 1
            }
            
            i = i+1
            iNew = iNew+1
            iOld = iOld+1
        }
    }
}
