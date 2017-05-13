//
//  Counter.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 29/04/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Stevia
import Komponents

class Counter: Component {
    
    var state = 0
    
    var color = UIColor.red
    
    init(color: UIColor) {
        self.color = color
    }
    
    func render() -> Tree {
        return
            View(
                color: color,
                layout: Layout().size(100), [
                    VerticalStack(layout: .center, [
                        Label("Counter : \(state)"),
                        Button("Tap me",
                               tap: { [weak self] in self?.updateState{ $0 += 1 } },
                               props: { $0.setTitleColor(.red, for: .normal) }
                        )
                    ])
                ])
    }
    
    deinit {
        print("😀 DEstroying Counter")
    }
}
