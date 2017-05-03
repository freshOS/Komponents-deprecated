//
//  KomponentsEngine.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Stevia
import UIKit

public class Komponents {
    public static var logsEnabled = false
}


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
    }
    
    public func updateComponent(_ component: IsComponent, patching:Bool) {
        // VC Component
        if let vc = component as? UIViewController {
            if patching && component.enablePatching() {
                DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
                    // Test rerender in another view first.
                    let myView = UIView()
                    self.renderer.render(component, in: myView, withEngine: self,atIndex: nil)
                    
                    let r = UIKitReconcilier()
                    r.mainUpdateChildren(vc.view, myView)
                    
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
            if patching && component.enablePatching() {
                DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
                    // Test rerender in another view first.
                    let myView = UIView()
                    self.renderer.render(component, in: myView, withEngine: self, atIndex: nil)
                    
                    let r = UIKitReconcilier()
                    r.mainUpdateChildren(viewComponent, myView)
                    
                }
            } else {
                // Re-render all
                for sv in viewComponent.subviews {
                    sv.removeFromSuperview()
                }
                self.renderer.render(component, in: viewComponent, withEngine: self, atIndex: nil)
            }
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
