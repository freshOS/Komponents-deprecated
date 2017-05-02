//
//  KomponentsEngine.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Stevia
import UIKit

public class KomponentsEngine {
    
    static let shared = KomponentsEngine()
    
    
    // retain non-VC components here
    var componentsMap = [String: IsComponent]()
    var viewMap = [String: UIView]()
    
    func viewForComponentId(_ id :String) -> UIView {
        return viewMap[id]!
    }
    
    private convenience init() {
        self.init(renderer:UIKitRenderer())
    }
    
    let renderer: Renderer
    private init(renderer: Renderer) {
        self.renderer = renderer
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name(rawValue:"KomponentsStateChanged"),
                         object: nil,
                         queue: nil) { [unowned self] n in
                if let componentToUpdate = n.object as? IsComponent {
                    self.updateComponent(componentToUpdate)
                }
            }
    }
    
    public func updateComponent(_ component: IsComponent) {
        // VC Component
        if let vc = component as? UIViewController {
            if let firstView = vc.view.subviews.first {
                DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
                    // Test rerender in another view first.
                    let myView = UIView()
                    self.renderer.render(component, in: myView, withEngine: self,atIndex: nil)
                    
                    let r = UIKitReconcilier()
                    r.mainUpdateChildren(vc.view, myView)
                        
                    // Compare
//                    if let label = vc.view.subviews.first as? UILabel, let newLabel = myView.subviews.first as? UILabel {
//                        print(label)
//                        print(newLabel)
//                        
//                        // Copy from one to the other.
//                        label.text = newLabel.text
//                    } else {
//                        for sv in vc.view.subviews {
//                            sv.removeFromSuperview()
//                        }
//                        // Re-render compoenent in superview.
//                        self.renderer.render(component, in: vc.view, withEngine: self, atIndex: nil)
//                    }
                
                }
            } else {
                // Rerender all.
                for sv in vc.view.subviews {
                    sv.removeFromSuperview()
                }
                // Re-render compoenent in superview.
                self.renderer.render(component, in: vc.view, withEngine: self, atIndex: nil)
            }
        } else if let cellComponent = component as? UITableViewCell { // UITableViewCell Component
            

            if var canBeDirty = cellComponent as? CanBeDirty {
            
                if canBeDirty.isDirty {
                    //TODO Here only rerender if render() yield a diffrerent node
                    for sv in cellComponent.contentView.subviews {
                        sv.removeFromSuperview()
                    }
                    self.renderer.render(component, in: cellComponent.contentView, withEngine: self, atIndex: nil)
                    canBeDirty.isDirty = false
                }
            }
        } else if let viewComponent = component as? UIView { // UIView Component
            for sv in viewComponent.subviews {
                sv.removeFromSuperview()
            }
            self.renderer.render(component, in: viewComponent, withEngine: self, atIndex: nil)
        } else {
            // Non-VC Component
            let associatedView = self.viewForComponentId(component.uniqueIdentifier)
            if let superview = associatedView.superview {
                var stackViewIndex: Int?
                if let stackView = superview as? UIStackView {
                    stackViewIndex = stackView.arrangedSubviews.index(of: associatedView)
                }
                // Remove previous view hierarchy.
                associatedView.removeFromSuperview()
                // Re-render compoenent in superview.
                self.renderer.render(component, in: superview, withEngine: self, atIndex: stackViewIndex)
            }
        }
    }
    
    public func render<C: IsComponent>(component: C, in view: UIView) {
        renderer.render(component, in: view, withEngine: self, atIndex: nil)
    }
}


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
        
        if let label = oldNode as? UILabel, let newLabel = newNode as? UILabel {
            if newLabel.text != label.text {
                
                updates.append {
                    label.text = newLabel.text
                }
                print("Patch text")
            }
            
            if newLabel.textColor != label.textColor {
                updates.append {
                    label.textColor = newLabel.textColor
                }
                print("Patch textColor")
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
            var newChildNode = newNode.subviews[iNew]
            var oldChildNode = oldNode.subviews[iOld]
            var retChildNode = walk(oldChildNode, newChildNode)
            
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
