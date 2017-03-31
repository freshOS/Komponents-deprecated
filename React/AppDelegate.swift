//
//  AppDelegate.swift
//  React
//
//  Created by Sacha Durand Saint Omer on 29/03/2017.
//  Copyright © 2017 Freshos. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Classic RootVC Setup
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        
    
        
        // Load our component
        let engine = WeactEngine()
        engine.render(component: ActionsBar(), in:vc.view)
        return true
    }
}

//struct TestC: Component {
//    
//    var state: Int = 0
//    
//    func render(state: Int) -> Node {
//        return
//            View(style: { $0.backgroundColor = .blue }, layout: { v in
//                v.size(200)
//                v.centerInContainer()
//            }, [
//                Button("Hello",
//                       tap: { print("hello you") },
//                       layout: { $0.centerInContainer() })
//            ])
//    }
//}



////
////struct ConreteCompoenent<State>:AComponent {
////    
////    var _render: (Photo) -> TextNode!
////    
////    init<State,NodeType>(c:AComponent) where c.State == State, c.NodeType == NodeType {
////        _render = c.render
////    }
////    
////    func render(state: Photo) -> TextNode {
////        return _ render
////    }
////    
////}
//
////func rendertoUIView(component: ConreteCompoenent) -> UIView {
////    let v = UIView()
////    v.backgroundColor = .yellow
////    return v
////}
//
//
//protocol Component {
//    
//    func render() -> UIView
//}
//
//
//class CustomComponent:Component {
//    internal func render() -> UIView {
//        return view
//    }
//    var view = UIView() // store view?
//    
//    static func newWith(_ c:Component) -> CustomComponent {
//        let custom = CustomComponent()
//        custom.view = c.render()
//        return custom
//    }
//}
//
//class React {
//    var window: UIWindow?
//    func render(_ component:Component) {
//        let c = UIViewController()
//        c.view = component.render()
//        window?.rootViewController = c
//    }
//}
//
//protocol ReactView {
//    
//}
//
//final class View: UIView, Layoutable, Component {
//    internal var layoutBlock: ((View) -> ())?
//    
//    convenience init(style:((UIView)->())? = nil, layout:((UIView)->())? = nil , children:Component... ) {
//        self.init(frame: CGRect.zero)
//        layoutBlock = layout
//        style?(self)
//        
//        for child in children {
//            
//            let childView = child.render()
//            childView.translatesAutoresizingMaskIntoConstraints = false
//            addSubview(childView)
//            
//            
//            if let layoutable = child as? Layoutable {
//                layoutable.layout()
//            }
//        }
//        
//        layout?(self)
//    }
//    
////    convenience init(style:(UIView)->(), layout:((UIView)->())? = nil , children:UIView... ) {
////        self.init(frame: CGRect.zero)
////        layoutBlock = layout
////        style(self)
////        
////        for child in children {
////            child.translatesAutoresizingMaskIntoConstraints = false
////            addSubview(child)
////            
////            
////            if let layoutable = child as? Layoutable {
////                layoutable.layout()
////            }
////        }
////        
////        layout?(self)
////    }
//    
//    func layout() {
//        layoutBlock?(self)
//    }
//    
//    func render() -> UIView {
//        return self
//    }
//    
//}
//
//final class Text: UILabel, Layoutable, Component {
//    internal var layoutBlock: ((Text) -> ())?
//    
//    convenience init(_ wording:String = "", style:((UILabel)->())? = nil, layout:((UIView)->())? = nil , children:[View]? = nil) {
//        self.init(frame: CGRect.zero)
//        layoutBlock = layout
//        style?(self)
//        
//        
//        if let children = children {
//            for child in children {
//                child.translatesAutoresizingMaskIntoConstraints = false
//                addSubview(child)
//                
//                child.layout()
//            }
//        }
//        
//        text = wording
//    }
//    
//    // ref
//    
//    convenience init(_ wording:String = "", style:((UILabel)->())? = nil, layout:((UIView)->())? = nil , children:[View]? = nil, ref: inout Text!) {
//        self.init(frame: CGRect.zero)
//        layoutBlock = layout
//        style?(self)
//        
//        
//        if let children = children {
//            for child in children {
//                child.translatesAutoresizingMaskIntoConstraints = false
//                addSubview(child)
//                
//                child.layout()
//            }
//        }
//        
//        text = wording
//        ref = self
//    }
//    
//    
//    func layout() {
//        layoutBlock?(self)
//    }
//    
//    func render() -> UIView {
//        return self
//    }
//}
//
//
//final class Button: UIButton, Layoutable, Component {
//    
//    var tapCallbacks = [()->Void]()
//    
//    internal var layoutBlock:((Button)->())?
//    
//    convenience init(image: UIImage, tap:@escaping (() -> Void)) {
//        self.init(frame: CGRect.zero)
//        setImage(image, for: .normal)
//        
//        addTarget(self, action: #selector(didTap), for: .touchUpInside)
//        
//        tapCallbacks.append(tap)
//    }
//    
//    func didTap() {
//        for tc in tapCallbacks {
//            tc()
//        }
//    }
//    
//    
//    
//    convenience init(image: UIImage, layout:((UIView)->())? = nil) {
//        self.init(frame: CGRect.zero)
//        setImage(image, for: .normal)
//        layoutBlock = layout
//    }
//    
//    
//    convenience init(ref: inout Button!) {
//        self.init(frame: CGRect.zero)
//        backgroundColor = .red
//        ref = self
//    }
//    
//    convenience init(_ wording:String = "", style:((UIButton)->())? = nil, layout:((UIView)->())? = nil , children:[View]? = nil) {
//        self.init(frame: CGRect.zero)
//        layoutBlock = layout
//        style?(self)
//        
//        if let children = children {
//            for child in children {
//                child.translatesAutoresizingMaskIntoConstraints = false
//                addSubview(child)
//                child.layout()
//            }
//        }
//        
//        setTitle(wording, for: .normal)
//        
//        backgroundColor = .red
//    }
//    
//    func layout() {
//        layoutBlock?(self)
//    }
//    
//    func render() -> UIView {
//        return self
//    }
//}
//
//
//final class VerticalStack: UIStackView, Layoutable, Component {
//    
//    internal var layoutBlock:((VerticalStack)->())?
//    
//    convenience init(style:((UIStackView)->())? = nil, layout:((UIStackView)->())? = nil , children:Component... ) {
//        self.init(frame: CGRect.zero)
//        
//        axis = .vertical
//        layoutBlock = layout
//        style?(self)
//        
//        for child in children {
//            let childView = child.render()
//            childView.translatesAutoresizingMaskIntoConstraints = false
//            addArrangedSubview(childView)
//            
//            
//            if let layoutable = child as? Layoutable {
//                layoutable.layout()
//            }
//        }
//        
//        //        layout?(self)
//    }
//    
//    func render() -> UIView {
//        return self
//    }
//    
//    func layout() {
//        layoutBlock?(self)
//    }
//}
//
//final class HorizontalStack: UIStackView, Layoutable, Component {
//    
//    internal var layoutBlock:((HorizontalStack)->())?
//    
//    convenience init(style:((UIStackView)->())? = nil, layout:((UIStackView)->())? = nil , children:Component... ) {
//        self.init(frame: CGRect.zero)
//        
//        axis = .horizontal
//        layoutBlock = layout
//        style?(self)
//        
//        for child in children {
//            let childView = child.render()
//            childView.translatesAutoresizingMaskIntoConstraints = false
//            addArrangedSubview(childView)
//            
//            
//            if let layoutable = child as? Layoutable {
//                layoutable.layout()
//            }
//        }
//        
//        layout?(self)
//    }
//    
//    func layout() {
//        layoutBlock?(self)
//    }
//    
//    func render() -> UIView {
//        return self
//    }
//}
//
//protocol Layoutable {
////    var layoutBlock:((Self)->())? { get set }
//    func layout()
//}

//extension Layoutable {
//    init(layout:((Self)->())? = nil ) {
//        layoutBlock = layout
//    }
//}
//
//

