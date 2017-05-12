//
//  HelloWorldVC.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 29/04/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Stevia
import Komponents

class HelloWorldVC: UIViewController, StatelessComponent {
    
    override func loadView() { loadComponent() }
    
    func render() -> Tree {
        title = "Hello World"
        return
            View(layout: .fill, [
                Label("Hello World", layout: .center)
            ])
    }
}
