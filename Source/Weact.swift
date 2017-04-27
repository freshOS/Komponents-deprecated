//
//  Weact.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
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
                         queue: nil) { _ in
                self.renderBlock()
            }
    }
    
    public func render<C: Component>(component: C, in view: UIView) {
        renderBlock = {
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
        renderBlock()
    }
}
