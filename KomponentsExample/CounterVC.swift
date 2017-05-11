//
//  CounterVC.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 29/04/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit
import Stevia
import Komponents

class CounterVC: UIViewController, Component {
        
    var state = 0
    
    override func loadView() { loadComponent() }
    
    func render() -> Tree {
        title = "Counter"        
        return
            View([
                VerticalStack(.center, [
                    Label("Counter : \(state)"),
                    Button("Tap me",
                           tap: { [weak self] in //be careful of the strong Ref ! (document this)
                            self?.updateState{ $0 += 1 }
                        }, props: {
                            $0.text = "Lool"
                            $0.setTitleColor(.red, for:.normal)
                    })
                ])
            ])
    }
    
    func enablePatching() -> Bool {
        return true
    }
}
