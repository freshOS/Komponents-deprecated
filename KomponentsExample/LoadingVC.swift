//
//  LoadingVC.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 29/04/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit
import Stevia
import Komponents

class LoadingVC: UIViewController, StatelessComponent {
    
    override func loadView() { loadComponent() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Loading"
    }
    
    func render() -> Tree {
        return
            View([
                HorizontalStack(layout: .center, [
                    Label("Loading..."), ActivityIndicatorView(.gray)
                ])
            ])
    }
}



























