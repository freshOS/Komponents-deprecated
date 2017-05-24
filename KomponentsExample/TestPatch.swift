//
//  TestPatch.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 14/05/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Komponents

class TestPatch: UIViewController, Component {
    var reactEngine: KomponentsEngine?

    var state = false
    
    override func loadView() {
        loadComponent()
    }
    
    func render() -> Tree {
        
        if !state {
            return
                View(
                    View(color:.blue, layout:Layout().size(100).top(100).left(10)),
                    View(color: .lightGray,
                         layout: Layout().size(100).top(100).centerHorizontally())
                )
        } else {
            return
                View(
                    View(color:.blue, layout:Layout().size(100).top(100).left(10)),
                    View(color:.lightGray, layout:Layout().size(100).top(100).centerHorizontally()),
                    View(color:.red, layout:Layout().size(100).top(100).right(10))
                )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            self.updateState { $0 = true }
        }
    }
}
