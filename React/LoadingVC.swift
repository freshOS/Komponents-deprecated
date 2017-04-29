//
//  LoadingVC.swift
//  WeactExample
//
//  Created by Sacha Durand Saint Omer on 29/04/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit
import Stevia
import Weact

class LoadingVC: UIViewController, StatelessComponent {
    
    override func loadView() { loadComponent() }
    
    func render() -> Node {
        return View(style: { $0.backgroundColor = .red }, [
            HorizontalStack(  layout: { $0.centerInContainer() }, [
                Label("Loading..."),
                ActivityIndicatorView(style: { $0.startAnimating() })
                ])
            ])
    }
}






























