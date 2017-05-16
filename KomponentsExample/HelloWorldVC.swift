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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hello World"
    }
    
    func render() -> Tree {
        return
            View([
                Label("Hello World", layout: .center)
            ])
    }
}
