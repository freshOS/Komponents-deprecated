//
//  LoopVC.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 27/04/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit
import Stevia
import Komponents

class LoopVC: UIViewController, StatelessComponent {
    
    override func loadView() { loadComponent() }
    
    func render() -> Tree {
        title = "Loops"
        return
            View([
                VerticalStack(props: { $0.spacing = 40 }, .center,
                    Array(1...4).map { Label("I told you \($0) times !") }
                )
            ])
    }
}


