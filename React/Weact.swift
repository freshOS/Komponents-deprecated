//
//  Weact.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit

class WeactEngine {
    
    var renderBlock = {}
    
    convenience init() {
        self.init(renderer:UIKitRenderer())
    }
    
    let renderer:Renderer
    private init(renderer:Renderer) {
        self.renderer = renderer
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"WeactStateChanged"), object: nil, queue: nil) { n in
            self.renderBlock()
        }
    }
    
    func render<C: Component>(component:C, in view: UIView) {
        view.backgroundColor = .white
        renderBlock = {
            // Clean
            for sv in view.subviews {
                sv.removeFromSuperview()
            }
            
            // Rerender
            let renderedView = self.render(component: component)
            
            renderedView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(renderedView)
            renderedView.fillContainer()
        }
        renderBlock()
    }
    
    func render<C: Component>(component:C) -> UIView {
        let rootView = UIView()
        let newV = component.render()
        renderer.render(newV, in: rootView)
        return rootView
    }
}
