//
//  KomponentsEngine.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

public class Komponents {
    public static var logsEnabled = false
}


public class KomponentsEngine {
    
//    var componentsMap = [String: IsComponent]()
//    var componentsChildren = [String: [String]]() // [ComponentID: [ChildComponentID]]
    var viewMap = [String: UIView]()

    func viewForComponentId(_ id :String) -> UIView {
        return viewMap[id]!
    }
//
//    public func updateComponent(_ component: IsComponent, patching:Bool) {
//        // VC Component
//        if let vc = component as? UIViewController {
//            if patching && component.enablePatching() {
//                DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
//                    // Test rerender in another view first.
//                    let myView = UIView()
//                    self.renderer.render(component, in: myView, withEngine: self,atIndex: nil, ignoreRefs: true)
//                    
//                    let r = UIKitReconcilier()
//                    r.mainUpdateChildren(vc.view, myView)
//                    
//                }
//            } else {
//                // Rerender all.
//                for sv in vc.view.subviews {
//                    sv.removeFromSuperview()
//                }
//                // Re-render compoenent in superview.
//                self.renderer.render(component, in: vc.view, withEngine: self, atIndex: nil, ignoreRefs: false)
//            }
//        } else if let cellComponent = component as? UITableViewCell { // UITableViewCell Component
//            
//
//            if var canBeDirty = cellComponent as? CanBeDirty {
//            
//                if canBeDirty.isDirty {
//                    //TODO Here only rerender if render() yield a diffrerent node
//                    for sv in cellComponent.contentView.subviews {
//                        sv.removeFromSuperview()
//                    }
//                    self.renderer.render(component, in: cellComponent.contentView, withEngine: self, atIndex: nil, ignoreRefs: false)
//                    canBeDirty.isDirty = false
//                }
//            }
//        } else if let viewComponent = component as? UIView { // UIView Component
//            if patching && component.enablePatching() {
//                DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
//                    // Test rerender in another view first.
//                    let myView = UIView()
//                    self.renderer.render(component,
//                                         in: myView,
//                                         withEngine: self,
//                                         atIndex: nil,
//                                         ignoreRefs: true)
//                    
//                    let r = UIKitReconcilier()
//                    r.mainUpdateChildren(viewComponent, myView)
//                    
//                }
//            } else {
//                // Re-render all
//                for sv in viewComponent.subviews {
//                    sv.removeFromSuperview()
//                }
//                self.renderer.render(component, in: viewComponent, withEngine: self, atIndex: nil, ignoreRefs: false)
//            }
//        } else {
//            let associatedView = self.viewForComponentId(component.uniqueIdentifier)
//            // Non-VC Component
//            
//            // TODO enable patching for non-VC  components
////            if patching && component.enablePatching(), let superview = associatedView.superview {
////                
////                DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
////                    // Test rerender in another view first.
////                    let myView = UIView()
////                    self.renderer.render(component, in: myView, withEngine: self,atIndex: nil)
////                    
////                    let r = UIKitReconcilier()
////                    r.mainUpdateChildren(superview, myView)
////                }
////            } else {
//                if let superview = associatedView.superview {
//                    var stackViewIndex: Int?
//                    if let stackView = superview as? UIStackView {
//                        stackViewIndex = stackView.arrangedSubviews.index(of: associatedView)
//                    }
//                    // Remove previous view hierarchy.
//                    associatedView.removeFromSuperview()
//                    // Re-render compoenent in superview.
//                    self.renderer.render(component, in: superview, withEngine: self, atIndex: stackViewIndex, ignoreRefs: false)
//                }
////            }
//        }
//        
//    }
//
//    public func render<C: IsComponent>(component: C, in view: UIView) {
//        renderer.render(component, in: view, withEngine: self, atIndex: nil, ignoreRefs: false)
//    }
//    
//    public func render(component: IsComponent, in view: UIView) {
//        renderer.render(component, in: view, withEngine: self, atIndex: nil, ignoreRefs: false)
//    }
//    
//    public func render(component: Renderable, in view: UIView) {
//        renderer.render(component, in: view, withEngine: self, atIndex: nil, ignoreRefs: false)
//    }
//    
    
    
    /// NEW API
    
    public func updateComponent(_ component: IsComponent, patching:Bool) {
//        render(component: component, in: <#T##UIView#>)
        
        //TEST
        renderer.engine = self
       
        if let vc = component as? UIViewController {
            render(component: component, in: vc.view)
        } else {
            
            // rerender full tree of root component.
            
//            let associatedView = self.viewForComponentId(component.uniqueIdentifier)
            
            //            let associatedView = self.viewForComponentId(component.uniqueIdentifier)
        
//            let associatedView = renderer.viewForComponent(component: component)
//            print(associatedView)
//            
//            
//            if let superview = associatedView.superview {
//                var stackViewIndex: Int?
//                if let stackView = superview as? UIStackView {
//                    stackViewIndex = stackView.arrangedSubviews.index(of: associatedView)
//                }
//                // Remove previous view hierarchy.
//                associatedView.removeFromSuperview()
//                // Re-render compoenent in superview.
//                self.renderer.render(component, in: superview, withEngine: self, atIndex: stackViewIndex, ignoreRefs: false)
//            }


        }
        
    }
    
    
    let renderer = UIKitRenderer()
    
//    var latestRenderedTree:Tree?
    
    var componentTreeMap = [String:Tree]()
    
    func latestRenderedTreeForComponent(_ component: IsStatefulComponent) -> Tree? {
        return componentTreeMap[component.uniqueComponentIdentifier]
    }
    
    var rootComponent:IsComponent?
    public var rootView:UIView?
    
    func render(subComponent:IsComponent) {
        if let vc = rootComponent as? UIViewController {
            render(component: rootComponent!, in: vc.view)
        } else if let rootView = rootView {
            render(component: subComponent, in: rootView)
        }
    }
    
    func render(component: IsComponent, in view: UIView) {
        rootComponent = component
        renderer.engine = self
        if let component = component as? IsStatefulComponent {
            DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
                self.printTimeElapsedWhenRunningCode(title: "Render", operation: {
                    let newTree = component.render()
                    if let latestRenderedTree = self.latestRenderedTreeForComponent(component), component.forceRerender() == false {
                        if areTreesEqual(latestRenderedTree, newTree) {
                            print("Nothing changed, do nothing")
                        } else {
                            let reconcilier = UIKitReconcilier()
                            reconcilier.engine = self
                            reconcilier.mainUpdateChildren(latestRenderedTree, newTree)
                        }
                    } else {
                        self.componentTreeMap[component.uniqueComponentIdentifier] = newTree
                        DispatchQueue.main.async {
                            if self.rootView == nil { // not a subcomponent
                                // empty view if previously rendered
                                for sv in view.subviews { // TODO put inside rendere?
                                    sv.removeFromSuperview()
                                }
                            }
                            self.renderer.render(tree: newTree, in: view)
                            self.log(newTree)
                            component.didRender()
                        }
                    }
                })
            }
        } else {
            // Stateless compoenent
            DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
                self.printTimeElapsedWhenRunningCode(title: "Render", operation: {
                    let newTree = component.render()
                    DispatchQueue.main.async {
                        // empty view if previously rendered
                        for sv in view.subviews { // TODO put inside rendere?
                            sv.removeFromSuperview()
                        }
                        self.renderer.render(tree: newTree, in: view)
                        self.log(newTree)
                        component.didRender()
                    }
                })
            }
        }
    }
    
    var counter = 0
    func log(_ tree: Tree) {
        var str = ""
        if counter == 0 {
            print("🌲")
        }
        for _ in 0..<counter {
            str += "-----"
        }
        
        print("\(str) \(type(of: tree)) (id: \(tree.uniqueIdentifier))")
        
        //subcomponenet
        if let subComponent = tree as? IsComponent {
            counter += 1
            let subTree = subComponent.render()
            log(subTree)
            counter -= 1
        } else {
            if tree.children.count > 0 {
                counter += 1
            }
            for c in tree.children {
                log(c)
            }
            if tree.children.count > 0 {
                counter -= 1
            }
        }
    }
    
    func printTimeElapsedWhenRunningCode(title:String, operation:()->()) {
        let startTime = CFAbsoluteTimeGetCurrent()
        operation()
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("⏱ Rendering in : \(timeElapsed) s")
    }
    
    func log(_ s:String) {
        if Komponents.logsEnabled {
            print(s)
        }
    }
}
