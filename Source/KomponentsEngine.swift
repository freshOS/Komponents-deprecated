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
    
    public init() {}
    
    public func updateComponent(_ component: IsComponent, patching: Bool) {
        renderer.engine = self
        if let vc = component as? UIViewController {
            render(component: component, in: vc.view)
        }
    }
    
    let renderer = UIKitRenderer()
    var latestRenderedTree: Tree?
    public var rootView: UIView?
    
    func render(subComponent: IsComponent) {
        if let rootView = rootView {
            render(component: subComponent, in: rootView)
        }
    }
    
    let backgroundSerialQueue = DispatchQueue(label: "bgQueue", qos: .background)
    
    func render(component: IsComponent, in view: UIView) {
        renderer.engine = self
        if let component = component as? IsStatefulComponent {
            backgroundSerialQueue.async {
                self.printTimeElapsedWhenRunningCode(title: "Render", operation: {
                    var newTree = component.render()
                    
                    // ViewController, auto-fill root view
                    if component is UIViewController {
                        if var view = newTree as? View {
                            if view.layout == Layout() {
                                view.layout = .fill
                                newTree = view
                            }
                        }
                    }

                    if let latestRenderedTree = self.latestRenderedTree,
                        component.forceRerender() == false {
                        if areTreesEqual(latestRenderedTree, newTree) {
                            if Komponents.logsEnabled {
                                print("Nothing changed, do nothing")
                            }
                        } else {
                            let reconcilier = UIKitReconcilier()
                            reconcilier.engine = self
                            reconcilier.mainUpdateChildren(latestRenderedTree, newTree)
                            // Update tree
                            self.latestRenderedTree = newTree
                            self.log(newTree)
                        }
                    } else {
                        self.latestRenderedTree = newTree
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
                    var newTree = component.render()
                    
                    // ViewController, auto-fill root view
                    if component is UIViewController {
                        if var view = newTree as? View {
                            if view.layout == Layout() {
                                view.layout = .fill
                                newTree = view
                            }
                        }
                    }
                    
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
            if Komponents.logsEnabled {
            var str = ""
            if counter == 0 {
                print("🌲")
            }
            for _ in 0..<counter {
                str += "-----"
            }
            
            if let associatedView = renderer.nodeIdViewMap[tree.uniqueIdentifier] {
                print("\(str) \(type(of: tree)) (id: \(tree.uniqueIdentifier)) view: \(associatedView)")
            } else {
                print("no associatedView")
                print("\(str) \(type(of: tree)) (id: \(tree.uniqueIdentifier))")
            }

            //subcomponenet
            if let subComponent = tree as? IsComponent {
                counter += 1
                let subTree = subComponent.render()
                log(subTree)
                counter -= 1
            } else {
                if !tree.children.isEmpty {
                    counter += 1
                }
                for c in tree.children {
                    log(c)
                }
                if !tree.children.isEmpty {
                    counter -= 1
                }
            }
        }
    }
    
    func printTimeElapsedWhenRunningCode(title: String, operation: () -> Void) {
        if Komponents.logsEnabled {
            let startTime = CFAbsoluteTimeGetCurrent()
            operation()
            let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
            print("⏱ Rendering in : \(timeElapsed) s")
        } else {
            operation()
        }
    }
    
    func log(_ s: String) {
        if Komponents.logsEnabled {
            print(s)
        }
    }
}
