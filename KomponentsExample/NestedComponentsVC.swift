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

class NestedComponentsVC: UIViewController, StatelessComponent {
    
    override func loadView() { loadComponent() }
    
    func render() -> Tree {
        title = "Nested Components"
        return
            View(layout: .fill, [
                VerticalStack(
                    props: { $0.spacing = 10 },
                    .center, [
                    Counter(color: .blue),
                    Counter(color: .red),
                    Counter(color: .green),
                    Counter(color: .yellow)
                ])
            ])
    }
    
    deinit {
        print("😀 DEstroying NestedComponentsVC")
        willDeinitComponent()
    }
    
}
