//
//  OldLogic.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 12/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation


//class OldUIKitRenderer: Renderer {
//
//    weak var engine: KomponentsEngine!
//    weak var parentComponent: IsComponent?
//
//    func render(_ renderable: Renderable,
//                in rootView: UIView,
//                withEngine: KomponentsEngine,
//                atIndex: Int? = nil,
//                ignoreRefs: Bool = false) {
//
//        if rootView.superview != nil {
//            if let c = renderable as? IsComponent, Komponents.logsEnabled {
//                print("⚛️ Rendering \(c) : \(c.uniqueIdentifier)")
//            }
//        }
//
//
//        engine = withEngine
//
//
//
//        if let cell = rootView as? UITableViewCell {
//
//
//            let compoenentRootView = viewFor(renderable: renderable, in:cell.contentView, atIndex: atIndex, ignoreRefs: ignoreRefs) //recursive
//
//
//
//                compoenentRootView.fillContainer()
//
//
//            if let c = renderable as? IsComponent {
//                c.didRender()
//            }
//            if renderable is UIViewController || renderable is UIView {
//                compoenentRootView.fillContainer()
//            }
//
//            if let c = renderable as? IsComponent {
//                c.didRender()
//            }
//        } else {
//            let compoenentRootView = viewFor(renderable: renderable, in:rootView, atIndex: atIndex, ignoreRefs: ignoreRefs) //recursive
//
//            if renderable is UIViewController || renderable is UIView {
//                compoenentRootView.fillContainer()
//            }
//
//            if let c = renderable as? IsComponent {
//                c.didRender()
//            }
//        }
//    }


// TODO ignore refs on difing so as not to erase pointers ? needed taht we dont build ui?


//
//    @discardableResult
//    func viewFor(renderable: Renderable, in parentView: UIView, atIndex: Int? = nil, ignoreRefs: Bool) -> UIView {
//
//        // Store Parent component to associated it with its future children.
//        if let c = renderable as? IsComponent, c is UIViewController || c is UIView {
//            parentComponent = c
//        }
//
//        var theView: UIView?
//        var node = renderable.render()
//

//
//        if let theView = theView {
//
//
//            // Single node inside View: use fillContainer as default layout.
//            if node is View {
//                if node.children.count == 1 {
//                    if var singleChild = node.children[0] as? VerticalStack {
//                        if singleChild.layoutBlock == nil {
//                            singleChild.layoutBlock = {
//                                $0.fillContainer()
//                            }
//                            node.children[0] = singleChild
//                        }
//                    }
//
//                }
//            }
//
//
//            // TEST
//            // Fill view children by default if the view nor the children have
//            //  layout specified.
//            if node is View {
//
//                var hasNolayout = false
//
//                if let view = node as? View {
//                    if view.layoutBlock == nil {
//                        hasNolayout = true
//                    }
//                }
//
//
//                if hasNolayout {
//                    node.children = node.children.map { c in
//
//                        //TODO refactor
//
//                        // View child
//                        if var c = c as? View {
//                            if c.layoutBlock == nil {
//                                c.layoutBlock = {
//                                    $0.fillContainer()
//                                }
//                                return c
//                            }
//                        }
//
//                        // Button child
//                        if var c = c as? Button {
//                            if c.layoutBlock == nil {
//                                c.layoutBlock = {
//                                    $0.fillContainer()
//                                }
//                                return c
//                            }
//                        }
//
//                        // Image child
//                        if var c = c as? Image {
//                            if c.layoutBlock == nil {
//                                c.layoutBlock = {
//                                    $0.fillContainer()
//                                }
//                                return c
//                            }
//                        }
//
//                        // Map child
//                        if var c = c as? Map {
//                            if c.layoutBlock == nil {
//                                c.layoutBlock = {
//                                    $0.fillContainer()
//                                }
//                                return c
//                            }
//                        }
//
//                        return c
//                    }
//                }
//            }
//
//
//
//            for c in node.children {
//                viewFor(renderable: c, in: theView, ignoreRefs: ignoreRefs)
//            }
//
//            if let viewNode = node as? View {
//                if !viewNode.childrenLayout.isEmpty {
//                    var newArray:[Any] = [Any]()
//                    for a in viewNode.childrenLayout {
//                        if let c = a as? Int {
//                            newArray.append(CGFloat(c))
//                        } else if let n = a as? Node {
//                            newArray.append(viewFor(renderable: n, in: theView, ignoreRefs: ignoreRefs))
//                        } else if let array = a as? [Any] {
//                            let transformedArray:[Any] = array.map { x in
//                                if let i = x as? Int {
//                                    return CGFloat(i)
//                                } else if let n = x as? Node {
//                                    return viewFor(renderable: n, in: theView, ignoreRefs: ignoreRefs)
//                                }
//                                return ""
//                            }
//                            newArray.append(transformedArray)
//                        }
//                    }
//
//                    // Test verical margins
//                    var previousMargin: CGFloat?
//                    var previousView: UIView?
//                    for v in newArray {
//                        if let m = v as? CGFloat {
//                            previousMargin = m
//                        }
//                        if let av = v as? UIView {
//                            if let pv = previousView, let pm = previousMargin {
//                                theView.layout(
//                                    pv,
//                                    pm,
//                                    av
//                                )
//                                previousView = nil
//                                previousMargin = nil
//                            }
//
//                            if let pm = previousMargin {
//                                av.top(pm)
//                                previousMargin = nil
//                            }
//                            previousView = av
//                        }
//
//                        if let horizontalArray = v as? [Any] {
//
//                            var previousHMargin: CGFloat?
//                            var previousHView: UIView?
//                            for x in horizontalArray {
//
//                                if let m = x as? CGFloat {
//                                    previousHMargin = m
//
//                                    if let av = previousHView {
//                                        av.right(m)
//                                    }
//
//                                }
//                                if let av = x as? UIView {
//                                    if let phm = previousHMargin {
//                                        av.left(phm)
//                                    }
//
//                                    //copied
//                                    if let pv = previousView, let pm = previousMargin {
//                                        theView.layout(
//                                            pv,
//                                            pm,
//                                            av
//                                        )
//                                        previousView = nil
//                                        previousMargin = nil
//                                    }
//
//                                    previousHView = av
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//
//        // Hierarchy
//        if let theView = theView {
//            if let aComponent = renderable as? IsComponent, !(aComponent is UIViewController), !(aComponent is UIView)  {
//                let cId = aComponent.uniqueIdentifier
//                // only if not present
//                if engine.componentsMap.index(forKey: cId) == nil {
//                    engine.componentsMap[cId] = aComponent //// Retain the componenent
//
//                    if let parent = parentComponent {
//                        if let children = engine.componentsChildren[parent.uniqueIdentifier] {
//                            engine.componentsChildren[parent.uniqueIdentifier] = (children + [cId])
//                        } else {
//                            engine.componentsChildren[parent.uniqueIdentifier] = [cId]
//                        }
//                    }
//                }
//                engine.viewMap[cId] = theView // update view entry.
//            }
//
//            theView.translatesAutoresizingMaskIntoConstraints = false
//            if let stackView = parentView as? UIStackView {
//
//                if let atIndex = atIndex {
//                    stackView.insertArrangedSubview(theView, at: atIndex)
//                } else {
//                    stackView.addArrangedSubview(theView)
//                }
//            } else {
//                parentView.addSubview(theView)
//            }
//        }
//
//        node.applyLayout?()
//
//        testLayoutBlock()
//
//        node.applyStyle?()
//
//        if let tfNode = node as? TextView {
//            tfNode.registerTextChanged?(theView as! UITextView)
//        }

//        return theView ?? UIView()
//    }
//}
