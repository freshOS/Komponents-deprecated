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

protocol Component:class, Renderable {
    
    associatedtype State
    var state: State { get set }
    func render(state: State) -> Renderable
    func updateState(_ block:(inout State) -> Void)
}

extension Component {
    
    func render() -> Renderable {
        print(state)
        return render(state: state)
    }
    
    func updateState(_ block:(inout State) -> Void) {
        block(&state)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"WeactStateChanged"), object: nil)
        
    }
}

protocol Renderer {
    func render(_ renderable: Renderable, in rootView: UIView)
}


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
    
//    func render<C: Component, State>(component:C, with state:State, in view: UIView) where C.State == State {
//        view.backgroundColor = .white
//        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
//            
//            // Clean
//            for sv in view.subviews {
//                sv.removeFromSuperview()
//            }
//            
//            // Rerender
//            let renderedView = self.render(component: component, with: state)
//            
//            renderedView.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(renderedView)
//            renderedView.fillContainer()
//        }
//    }
//    
//    func render<C: Component, State>(component:C, with state:State) -> UIView where C.State == State {
//        let rootView = UIView()
//        renderer.render(component.render(state: state), in: rootView)
//        return rootView
//    }
    
    func render<C: Component>(component:C, in view: UIView) {
        view.backgroundColor = .white
        renderBlock = {
            
//            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
            
                // Clean
                for sv in view.subviews {
                    sv.removeFromSuperview()
                }
                
                // Rerender
                let renderedView = self.render(component: component)
                
                renderedView.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(renderedView)
                renderedView.fillContainer()
//            }
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

