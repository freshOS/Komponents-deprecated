//
//  Weact.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Stevia
import UIKit

public class WeactEngine {
    
    
    var componentsMap = [Int: IsComponent]()
    var viewMap = [Int: UIView]()
    var nodeMap = [Int: Node]()
    
    func nodeForComponentId(_ id :Int) -> Node {
        return nodeMap[id]!
    }
    
    func viewForComponentId(_ id :Int) -> UIView {
        return viewMap[id]!
    }
    
    var renderBlock = {}
    
    public convenience init() {
        self.init(renderer:UIKitRenderer())
    }
    
    let renderer: Renderer
    private init(renderer: Renderer) {
        self.renderer = renderer
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name(rawValue:"WeactStateChanged"),
                         object: nil,
                         queue: nil) { n in
                self.notificationObject = n.object
                self.renderBlock()
            }
    }
    
    var notificationObject:Any?
    
    public func render<C: IsComponent>(component: C, in view: UIView) {
        renderBlock = {
            if let object = self.notificationObject {
                
                if let componentToUpdate = object as? IsComponent {
//                    print(componentToUpdate.uniqueIdentifier)
                    let associatedView = self.viewForComponentId(componentToUpdate.uniqueIdentifier)
//                    print(associatedView)
                    
                    if let superview = associatedView.superview {
                        
                        // Remove previous view hierarchy.
                        associatedView.removeFromSuperview()
                        
                        // Re-render compoenent in superview.
                        
                        self.renderer.render(componentToUpdate, in: superview, withEngine: self)
                    }
                    
                }
                
                if object is C {
//                    print("⚛️ Re-Rendering \(component)")
                    for sv in view.subviews {
                        sv.removeFromSuperview()
                    }
                    
                    let node = component.render()
                    self.renderer.render(node, in: view, withEngine: self)
                    
                    // Fill first node in container view
                    if let firstNodeView = view.subviews.first {
                        firstNodeView.fillContainer()
                    }
                }
            } else {
//                print("⚛️ Rendering \(component)")
                for sv in view.subviews {
                    sv.removeFromSuperview()
                }
                
//                let node = component.render()
                self.renderer.render(component, in: view, withEngine: self)
                
                // Fill first node in container view
                if let firstNodeView = view.subviews.first {
                    firstNodeView.fillContainer()
                }
            }
            
            
        }
        renderBlock()
    }
}
