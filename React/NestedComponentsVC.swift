//
//  NestedComponentsVC.swift
//  WeactExample
//
//  Created by Sacha Durand Saint Omer on 29/04/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Stevia
import Weact

class NestedComponentsVC: UIViewController, StatelessComponent {
    
    override func loadView() { loadComponent() }
    
//    func render() -> Node {
//        title = "Nested Components"
//        return
//            View(style: { $0.backgroundColor = .white }, [
//                
////                VerticalStack(style: { $0.spacing = 10 },
////                              layout: { $0.centerInContainer() }, [
//                Counter(layout: { $0.right(0).top(0) }),
//                Counter(layout: { $0.left(0).top(0) }),
//                Counter(layout: { $0.centerInContainer() }),
//                Counter(layout: { $0.left(0).bottom(0) }),
//                Counter(layout: { $0.right(0).bottom(0) }),
////                                Counter()
////                ])
//            ])
//    }
    
    func render() -> Node {
        title = "Nested Components"
        return
            View(style: { $0.backgroundColor = .white }, [
                VerticalStack(
                    style: { $0.spacing = 10 },
                    layout: { $0.centerInContainer() }, [
                    Counter(color: .blue),
                    Counter(color: .red),
                    Counter(color: .green),
                    Counter(color: .yellow)
                ])
            ])
    }
    
    
}
