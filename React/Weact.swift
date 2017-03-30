//
//  Weact.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit

protocol TestComponent {
    associatedtype State
    func render(state: State) -> Node
}

protocol Renderer {
    func render(_ node: Node, in rootView: UIView)
}


class WeactEngine {
    
    let rootView = UIView()
    
    convenience init() {
        self.init(renderer:UIKitRenderer())
    }
    
    let renderer:Renderer
    private init(renderer:Renderer) {
        self.renderer = renderer
    }
    
    func render<C: TestComponent, State>(component:C, with state:State) -> UIView where C.State == State {
        rootView.backgroundColor = .white
        renderer.render(component.render(state: state), in: rootView)
        return rootView
    }
    
}

