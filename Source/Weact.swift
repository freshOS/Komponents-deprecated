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
                if object is C {
                    print("⚛️ Re-Rendering \(component)")
                    for sv in view.subviews {
                        sv.removeFromSuperview()
                    }
                    
                    let node = component.render()
                    self.renderer.render(node, in: view)
                    
                    // Fill first node in container view
                    if let firstNodeView = view.subviews.first {
                        firstNodeView.fillContainer()
                    }
                }
            } else {
                print("⚛️ Rendering \(component)")
                for sv in view.subviews {
                    sv.removeFromSuperview()
                }
                
                let node = component.render()
                self.renderer.render(node, in: view)
                
                // Fill first node in container view
                if let firstNodeView = view.subviews.first {
                    firstNodeView.fillContainer()
                }
            }
            component.didRender()
            
        }
        renderBlock()
    }
}
