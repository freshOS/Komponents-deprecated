//
//  Counter.swift
//  WeactExample
//
//  Created by Sacha Durand Saint Omer on 29/04/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Stevia
import Weact

class Counter: Component {
    
    var state = 0
    
    var layout = { (v:UIView) in }
    
//    init(layout: @escaping (UIView) -> Void) {
//        self.layout = layout
//    }
    
    var color = UIColor.red
    
    init(color: UIColor) {
        self.color = color
    }
    
    func render() -> Node {
        return View(style: { $0.backgroundColor = self.color },
                    layout: {
                        $0.size(100)
                        self.layout($0)
        }, [
            VerticalStack(layout: { $0.centerInContainer() }, [
                Label("Counter : \(state)"),
                Button("Tap me",
                       tap: {
                        self.updateState{ $0 += 1 } },
                       style: { $0.setTitleColor(.red, for: .normal) }
                )
                ])
            ])
    }
}
