//
//  Weact.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

// TODO 
//compoenent  fixed size ? override var intrinsicContentSize: CGSize { return CGSize(width: 79, height: 32) }

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
        
//        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
//            self.renderBlock()
//        }
    }
    
    func render<C: Component>(component:C, in view: UIView) {
        renderBlock = {
            // Clean
            for sv in view.subviews {
                sv.removeFromSuperview()
            }
            
            // Rerender
//            let renderedView = self.render(component: component)
            
            
            ///
//            let rootView = UIView()
            let node = component.render()
            self.renderer.render(node, in: view)
            
            
            
            //fill first node in container view
            if let firstNodeView = view.subviews.first {
                firstNodeView.fillContainer()
            }
            

            
            ///
            
//            renderedView.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(renderedView)
//            renderedView.fillContainer()
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

class NodeView: UIView, IsNodeView {
    convenience init() {
        self.init(frame: CGRect.zero)
        backgroundColor = .white
        renderNode()
    }
    
    func render() -> Node {
        return View([])
    }
    
    func layoutPass() { }
    
    func didRender() { }
}

extension IsNodeView where Self: UIView {
    
    func renderNode() {
        let renderer = UIKitRenderer()
        renderer.render(nodeView: self)
    }
}

extension IsPropsView where Self: UIView {
    
    func renderNode() {
        let renderer = UIKitRenderer()
        renderer.render(nodeView: self)
    }
}

protocol IsNodeView {
    func render() -> Node
    func layoutPass()
    func didRender()
}


protocol IsPropsView {
    associatedtype Props
    var props: Props { get }
    func render(props: Props) -> Node
    func layoutPass()
    func didRender()
}


class PropsView<Props>: UIView, IsPropsView {
    
    var props: Props
    
    init(props: Props) {
        self.props = props
        super.init(frame: CGRect.zero)
        
        backgroundColor = .white
        renderNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render(props: Props) -> Node {
        return View([])
    }
    
    func layoutPass() { }
    
    func didRender() { }
}


extension IsPropsView where Self: UIView {
    
    func didRender() {}
    
    func layoutPass() { }
}


// Helper to render a given compoennet in a UIView.
// By using this wrap, you can use componenets incrementally by migrating your UIView subclasses in your App.
class ComponentView<T:Component> :UIView {
    
    let component: T!
    
    let engine = WeactEngine()
    
    init(component: T) {
        self.component = component
        super.init(frame: CGRect.zero)
        engine.render(component:component, in: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override var intrinsicContentSize: CGSize {
//        return component.size()
//    }
}

