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
    
    func render() -> Node {
        title = "Loops"
        return
            View(style: { $0.backgroundColor = .white }, [
                VerticalStack(style: { $0.spacing = 40 }, layout: { $0.centerInContainer() },
                    Array(1...4).map { Label("I told you \($0) times !") }
                )
            ])
    }
}
