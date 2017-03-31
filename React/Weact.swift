//
//  Weact.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit


protocol Renderable {
    func render() -> Renderable
}

protocol Component:Renderable {
    
    associatedtype State
    var state: State { get }
    func render(state: State) -> Node
}

extension Component {
    
    func render() -> Renderable {
        return render(state: state)
    }
}

protocol Renderer {
    func render(_ renderable: Renderable, in rootView: UIView)
}


class WeactEngine {
    
    convenience init() {
        self.init(renderer:UIKitRenderer())
    }
    
    let renderer:Renderer
    private init(renderer:Renderer) {
        self.renderer = renderer
    }
    
    func render<C: Component, State>(component:C, with state:State, in view: UIView) where C.State == State {
        view.backgroundColor = .white
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
            
            // Clean
            for sv in view.subviews {
                sv.removeFromSuperview()
            }
            
            // Rerender
            let renderedView = self.render(component: component, with: state)
            
            renderedView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(renderedView)
            renderedView.fillContainer()
        }
    }
    
    func render<C: Component, State>(component:C, with state:State) -> UIView where C.State == State {
        let rootView = UIView()
        renderer.render(component.render(state: state), in: rootView)
        return rootView
    }
    
}

