//
//  HelloProps.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 29/04/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Stevia
import Komponents

class HelloPropsVC: UIViewController, StatelessComponent {
    
    private var name = ""
    
    convenience init(name: String) {
        self.init(nibName: nil, bundle: nil)
        self.name = name
    }
    
    override func loadView() { loadComponent() }
    
    func render() -> Tree {
        title = "Hello \(name)"
        return
            View(layout: .fill, [
                Label("Hello \(name)", layout: .center)
            ])
    }
}
