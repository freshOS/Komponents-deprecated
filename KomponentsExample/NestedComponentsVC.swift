//
//  NestedComponentsVC.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 29/04/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Stevia
import Komponents

class NestedComponentsVC: UIViewController, Component {
    
    var reactEngine: KomponentsEngine?
    var state: [Int] = [0, 0, 0] //counters
    
    override func loadView() { loadComponent() }
    
    func render() -> Tree {
        title = "Nested Components"
        return
            View([
                VerticalStack(
                    props: { $0.spacing = 10 },
                    layout: .center, [
                        
                        // Free function functional Componenent
                        FunctionalCounter(color: .blue, count: state[0], tap: { [weak self] in
                            self?.updateState { $0[0] += 1 }
                        }),
                        
                        // struct-namespaced functional component
                        BareCounter.render(color: .red, count: state[1], tap: { [weak self] in
                            self?.updateState { $0[1] += 1 }
                        }),
                        
                        // Self-contained stateful component.
                        StatefulCounter(color: .yellow),
                        
                        // StateLess component.
                        AStatelessComponent()
                ])
            ])
    }
    
    deinit {
        print("😀 DEstroying NestedComponentsVC")
        willDeinitComponent()
    }
    
}
