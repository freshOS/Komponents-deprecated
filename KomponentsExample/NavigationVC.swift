//
//  NavigationVC.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 29/04/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Stevia
import Komponents

class NavigationVC: UIViewController, StatelessComponent {

    override func loadView() { loadComponent() }
    
    func render() -> Node {
        title = "Examples"
        
        func buttonStyle(b: UIButton) {
            b.setTitleColor(UIColor(red: 0.04, green: 0.04, blue: 0.04, alpha: 1), for: .normal)
            b.setTitleColor(.gray, for: .highlighted)
            b.titleLabel?.textAlignment = .right
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

        return
            View(style: { $0.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1) }, [
                VerticalStack(layout: { |$0.centerInContainer()| },
                    sections.map { wording, vc in
                        return View(style: { $0.backgroundColor = .white },
                                    layout: { $0.height(50) },
                                    [
                            View(style: { $0.backgroundColor = UIColor(red: 0.89, green: 0.88, blue: 0.9, alpha: 1) },
                                 layout: { |$0.top(0).height(1)| }, []),
                            Button("\(wording)", tap: { [weak self] in
                                 self?.push(vc()) },
                                   style: buttonStyle,
                                   layout: { $0.fillContainer() })
                        ])
                    }
                )
            ])
    }

}

extension UIViewController {
    func push(_ vc: UIViewController) {
         navigationController?.pushViewController(vc, animated: true)
    }
}
