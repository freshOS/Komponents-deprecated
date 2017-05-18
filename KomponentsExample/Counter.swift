//
//  Counter.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 29/04/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Komponents

// Free function Functional Compoenent

func FunctionalCounter(color: UIColor, count: Int, tap:@escaping () -> Void) -> Tree {
    return
        View(color: color, layout: Layout().size(100), [
            VerticalStack(layout: .center, [
                Label("Counter : \(count)"),
                Button("Tap me", tap:tap, props: { $0.setTitleColor(.red, for: .normal) })
            ])
        ])
}

// Stateless componenent doos not need anything
struct BareCounter {
    
    static func render(color: UIColor, count: Int, tap:@escaping () -> Void) -> Tree {
        return
            View(color: color, layout: Layout().size(100), [
                VerticalStack(layout: .center, [
                    Label("Counter : \(count)"),
                    Button("Tap me", tap:tap, props: { $0.setTitleColor(.red, for: .normal) })
                ])
            ])
    }
}

class StatefulCounter: Component {
    
    var reactEngine: KomponentsEngine?
    var state = 0
    
    var color = UIColor.red
    
    init(color: UIColor) {
        self.color = color
        supportInjection()
    }
    
    func render() -> Tree {
        return
            View(
                color: color,
                layout: Layout().size(100), [
                    VerticalStack(layout: .center, [
                        Label("Counter : \(state)"),
                        Button("Tap me",
                               tap: { [weak self] in self?.updateState { $0 += 1 } },
                               props: { $0.setTitleColor(.red, for: .normal) }
                        )
                    ])
                ])
    }
}

struct AStatelessComponent: StatelessComponent {
    
    func render() -> Tree {
        return View(color: .blue, layout: Layout().size(100), [])
    }
    
}
