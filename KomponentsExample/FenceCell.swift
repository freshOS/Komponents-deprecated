//
//  FenceCell.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 09/05/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import Komponents

class FenceCell: StatelessComponent {
    
    private var wording = ""
    private var didActivate = { (b: Bool) in }
    
    init(_ wording: String = "Default", didActivate:@escaping (Bool) -> Void = { (b: Bool) in }) {
        self.wording = wording
        self.didActivate = didActivate
    }
    
    var stack = UIStackView()
    
    func render() -> Tree {
        return
            View(layout: Layout().height(100).fill(), [
                HorizontalStack(layout: Layout().fill(padding: 20), ref: &stack, [
                    Circle.render(withLayout: Layout().fillVertically()),
                    Label(wording),
                    Switch(true, changed: didActivate)
                ]),
                Separator.render()
            ])
    }
    
    func didRender() {
        stack.alignment = .center
        stack.spacing = 20
    }
}


// Circle
struct Circle {
    
    static func render(withLayout: Layout) -> Tree {
        return
            View(
                color: UIColor(red: 0, green: 0, blue: 1, alpha: 0.1),
                props: {
                    $0.borderColor = .blue
                    $0.borderWidth = 2
                    $0.cornerRadius = 30
                    $0.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            }, layout: withLayout.size(60))
    }
}

struct Separator {
    static func render() -> Tree {
        return
            View(color: UIColor.black.withAlphaComponent(0.05),
                 layout: Layout().fillHorizontally().top(0).height(1), [])
    }
}
