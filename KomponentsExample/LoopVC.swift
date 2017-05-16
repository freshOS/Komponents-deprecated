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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Loops"
    }
    
    func render() -> Tree {
        return
            View([
                VerticalStack(props: { $0.spacing = 10 },
                              layout: .center,
                    Array(1...10).map { Label("I told you \($0) time !") }
                )
            ])
    }
}
