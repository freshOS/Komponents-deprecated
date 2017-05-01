//
//  TodoVC.swift
//  WeactExample
//
//  Created by Sacha Durand Saint Omer on 01/05/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Stevia
import Weact

class TodoVC: UIViewController, Component {
    
    struct Item {
        let name: String
        let time: Date
    }
    
    struct State {
        var items = [Item]()
        var newtaskName = ""
    }
    
    var state = State()
    
    override func loadView() { loadComponent() }
    
    func render() -> Node {
        title = "Todo"
        return
            View(style: { $0.backgroundColor = .gray }, [
                VerticalStack(layout: { $0.centerHorizontally().top(100) }, [
                    Label("TODO", style : {
                        $0.font = UIFont.systemFont(ofSize: 30)
                        $0.textAlignment = .center
                    }),
                    HorizontalStack([
                        Field("My Next Thing",
                              wording: self.state.newtaskName,
                              textChanged: { [weak self] s in
                                self?.updateState { $0.newtaskName = s }
                              },
                              style: {
                                $0.backgroundColor = .white
                                $0.becomeFirstResponder()
                        }),
                        Button("Add #\(self.state.items.count+1)",
                               tap: { [weak self] in self?.addItem() })
                        ]),
                    VerticalStack(
                        self.state.items.map { Label("- \($0.name)") }
                    )
                ])
            ])
    }
    
    func addItem() {
        if state.newtaskName != "" {
            let newItem = Item(name: state.newtaskName, time: Date())
            updateState {
                $0.items.append(newItem)
                $0.newtaskName = ""
            }
        }
    }
    
}
