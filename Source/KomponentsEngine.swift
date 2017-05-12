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
    
    static let shared = KomponentsEngine()
//    
//    // retain non-VC components here
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
            
//            let associatedView = self.viewForComponentId(component.uniqueIdentifier)
            
            //            let associatedView = self.viewForComponentId(component.uniqueIdentifier)
        
            let associatedView = renderer.viewForComponent(component: component)
            print(associatedView)


        }
        
    }
    
    
    let renderer = UIKitRenderer()
    
    var latestRenderedTree:Tree?
    
//    func render(component: Renderable) -> UIView {
//        let tree = component.render()
//        return renderer.render(tree: tree)
//    }
    
    func render(component: Renderable, in view: UIView) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            
            self.printTimeElapsedWhenRunningCode(title: "Render", operation: {
                let newTree = component.render()
                if let latestRenderedTree = self.latestRenderedTree {
                    if areTreesEqual(latestRenderedTree, newTree) {
                        print("Nothing changed, do nothing")
                    } else {
                        print("Patch Views with new tree")
                        self.traverseForPatch(latestRenderedTree, newTree)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.renderer.render(tree: newTree, in: view)
                        self.latestRenderedTree = newTree
//                        print("nodeIdViewMap : \(self.renderer.nodeIdViewMap)")
                        self.log(newTree)
                    }
                }
                //            self.latestRenderedTree = newTree
            })
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
        } else if let hasChildren = tree as? HasChildren {
            
            if hasChildren.children.count > 0 {
                counter += 1
            }
            for c in hasChildren.children {
                log(c)
            }
            if hasChildren.children.count > 0 {
                counter -= 1
            }
        }
        

    }
    
    func printTimeElapsedWhenRunningCode(title:String, operation:()->()) {
        let startTime = CFAbsoluteTimeGetCurrent()
        operation()
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("Time elapsed for \(title): \(timeElapsed) s")
    }
    
    func traverseForPatch(_ tree: Tree, _ otherTree:Tree) {
        if !areTreesEqual(tree, otherTree) {
            testPatch(tree, otherTree)
        }
        
        for i in tree.children.indices {
            let treeChild = tree.children[i]
            let otherTreeChild = otherTree.children[i]
            traverseForPatch(treeChild, otherTreeChild)
        }
        
    }
    
    func testPatch(_ node: IsNode, _ newNode: IsNode) {
        if let label = node as? Label, let otherLabel = newNode as? Label {
            if label.props.text != otherLabel.props.text {
//                print("patch associatedView with new props \(otherLabel.props.text )")
//                print(renderer.nodeIdViewMap)
//                print(label.uniqueIdentifier)
//                print(otherLabel.uniqueIdentifier)
                if let uiLabel = renderer.nodeIdViewMap[label.uniqueIdentifier] as? UILabel {
                    log("💉 Patch text")
                    DispatchQueue.main.async {
                        uiLabel.text = otherLabel.props.text
                    }
                }
            }
        }
        
    }
    
    func log(_ s:String) {
        if Komponents.logsEnabled {
            print(s)
        }
    }
}
