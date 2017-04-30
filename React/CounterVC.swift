//
//  CounterVC.swift
//  WeactExample
//
//  Created by Sacha Durand Saint Omer on 29/04/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit
import Stevia
import Weact

class CounterVC: UIViewController, Component {
        
    var state = 0
    
    override func loadView() { loadComponent() }
    
    func render() -> Node {
        title = "Counter"
        return
            View(style: { $0.backgroundColor = .white }, [
                VerticalStack(layout: { $0.centerInContainer() }, [
                    Label("Counter : \(state)"),
                    Button("Tap me",
                           tap: { self.updateState{ $0 += 1 } },
                           style: { $0.setTitleColor(.red, for: .normal) }
                    )
                ])
            ])
    }
}
