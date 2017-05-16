//
//  NavigationVC.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 29/04/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Komponents

class NavigationVC: UIViewController, StatelessComponent {
    
    override func loadView() { loadComponent() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Examples"
    }
    
    let sections: [(String, (() ->(UIViewController)) )] = [
        ("Hello World", { HelloWorldVC() }),
        ("Hello Props", { HelloPropsVC(name:"Chuck Norris") }),
        ("LoadingScreen", { LoadingVC() }),
        ("Counter ", { CounterVC() }),
        ("Login Screen", { LoginVC() }),
        ("Nested Components", { NestedComponentsVC() } ),
        ("Loops", { LoopVC() } ),
        ("Timer", { TimerVC() } ),
        ("Todo", { TodoVC() } ),
        ("Default Nodes", { DefaultNodesVC() } ),
        ("Static Table", { StaticTableVC() } )
    ]
    
    func render() -> Tree {
        return
            View(
                color: UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1), [
                    VerticalStack(layout: Layout().centered().left(0).right(0),
                        sections.map { wording, vc in
                            return cell(wording: wording, vc: vc)
                        }
                )
            ])
    }
    
    func cell(wording: String, vc: @escaping () -> UIViewController) -> Tree {

        func buttonProps(b: inout ButtonProps) {
            b.setTitleColor(UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1), for: .normal)
            b.setTitleColor(.gray, for: .highlighted)
        }
        
        return
            View(layout: Layout().height(50), [
                View(
                    color: UIColor(red: 0.89, green: 0.88, blue: 0.9, alpha: 1),
                    layout: Layout().left(0).right(0).top(0).height(1), []
                ),
                Button(
                    "\(wording)",
                    tap: { [weak self] in self?.push(vc()) },
                    props: buttonProps,
                    layout: .fill
                )
            ])
    }
}
