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
    
    static let shared = WeactEngine()
    
    var componentsMap = [String: IsComponent]()
    var viewMap = [String: UIView]()
    var nodeMap = [String: Node]()
    
    func nodeForComponentId(_ id :String) -> Node {
        return nodeMap[id]!
    }
    
    func viewForComponentId(_ id :String) -> UIView {
        return viewMap[id]!
    }
    
    var renderBlock = {}
    
    private convenience init() {
        self.init(renderer:UIKitRenderer())
    }
    
    let renderer: Renderer
    private init(renderer: Renderer) {
        self.renderer = renderer
//        NotificationCenter.default
//            .addObserver(forName: NSNotification.Name(rawValue:"WeactStateChanged"),
//                         object: nil,
//                         queue: nil) { n in
//                self.notificationObject = n.object
//                            
//                if let componentToUpdate = n.object as? IsComponent {
////                    if self.componentsMap.keys.contains(componentToUpdate.uniqueIdentifier) {
//                        self.renderBlock()
////                    } else {
////                        print("NOT IN THIN SNEGINE")
////                    }
//                }
//                            
//                
//            }
    }
    
    var notificationObject:Any?
    
    
    public func render<C: IsComponent>(component: C, in view: UIView) {
        renderBlock = { [unowned self, weak component] in
            if let object = self.notificationObject {
//                if let componentToUpdate = object as? IsComponent {
//                    print(" ☝️ COMPONENT TO UPDATE : \(  componentToUpdate.uniqueIdentifier)")
//                    let associatedView = self.viewForComponentId(componentToUpdate.uniqueIdentifier)
//                    if let superview = associatedView.superview {
//                        var stackViewIndex: Int?
//                        if let stackView = superview as? UIStackView {
//                            stackViewIndex = stackView.arrangedSubviews.index(of: associatedView)
//                        }
//                        // Remove previous view hierarchy.
//                        associatedView.removeFromSuperview()
//                        // Re-render compoenent in superview.
//                        self.renderer.render(componentToUpdate, in: superview, withEngine: self, atIndex: stackViewIndex)
//                    }
//                }
//                
//                if object is C {
//                    //                    print("⚛️ Re-Rendering \(component)")
//                    for sv in view.subviews {
//                        sv.removeFromSuperview()
//                    }
//                    
//                    let node = component.render()
//                    self.renderer.render(node, in: view, withEngine: self, atIndex: nil)
//                    
//                    // Fill first node in container view
//                    if let firstNodeView = view.subviews.first {
//                        firstNodeView.fillContainer()
//                    }
//                }
            } else {
                print("⚛️ Rendering \(component)")
                for sv in view.subviews {
                    sv.removeFromSuperview()
                }
                if let c = component {
                    self.renderer.render(c, in: view, withEngine: self, atIndex: nil)
                }
                
                // Fill first node in container view
                if let firstNodeView = view.subviews.first {
                    firstNodeView.fillContainer()
                }
            }
        }
        renderBlock()
    }
    
    deinit {
        print("😀 Destroying Weact engine")
    }
}
