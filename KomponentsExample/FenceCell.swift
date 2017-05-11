////
////  FenceCell.swift
////  KomponentsExample
////
////  Created by Sacha Durand Saint Omer on 09/05/2017.
////  Copyright © 2017 Octopepper. All rights reserved.
////
//
//import Komponents
//import Stevia
//
//class FenceCell: StatelessComponent {
//    
//    private var wording = ""
//    private var didActivate = { (b:Bool) in }
//    
//    init(_ wording:String = "Default", didActivate:@escaping (Bool) -> Void = { (b:Bool) in }) {
//        self.wording = wording
//        self.didActivate = didActivate
//    }
//    
//    func render() -> Node {
//        return
//            View([
//                HorizontalStack(style: stackStyle, layout: { $0.fillContainer()}, [
//                    Circle(),
//                    Label(wording),
//                    Switch(true, changed: didActivate, style: { $0.onTintColor = .green })
//                ]),
//                Separator()
//            ])
//    }
//    
//    func stackStyle(s:UIStackView) {
//        s.alignment = .center
//        s.spacing = 20
//        s.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//        s.isLayoutMarginsRelativeArrangement = true
//    }
//}
//
//// Circle
//class Circle: StatelessComponent {
//    func render() -> Node {
//        return
//            View(
//                style: {
//                    $0.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.1)
//                    $0.layer.borderColor = UIColor.blue.cgColor
//                    $0.layer.cornerRadius = 30
//                    $0.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//                    $0.layer.borderWidth = 2
//            },layout: { $0.size(60) } )
//    }
//}
//
//class Separator: StatelessComponent {
//    func render() -> Node {
//        return
//            View(style: { $0.backgroundColor = UIColor.black.withAlphaComponent(0.05) },
//                 layout: { |$0.top(0).height(1)| }, [])
//    }
//}
