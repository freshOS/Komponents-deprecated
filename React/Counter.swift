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
    
    public var uniqueIdentifier: Int { return 527 }
    
    var state = 0
    
    func render() -> Node {
        return View(style: { $0.backgroundColor = .white },
                    layout: { $0.size(200) }, [
            VerticalStack(layout: { $0.fillContainer() }, [
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
