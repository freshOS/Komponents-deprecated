//
//  LoopExample.swift
//  WeactExample
//
//  Created by Sacha Durand Saint Omer on 27/04/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Stevia
import Weact

class TestLoop: StatelessComponent {
    
    public var uniqueIdentifier: Int { return 8 }
    
    func render() -> Node {
        let items = ["Hello", "How", "Are", "You?"]
        return
            View(style: { $0.backgroundColor = .white }, [
                VerticalStack(style: { $0.spacing = 40 }, layout: { $0.centerInContainer() },
                    items.map { Label($0) }
                )
            ])
    }
}
