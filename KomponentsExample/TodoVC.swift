//
//  TodoVC.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 01/05/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Stevia
import Komponents

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
    
    func render() -> Tree {
        title = "Todo"
        return
            View(
                color:.gray,
                layout: .fill, [
                    VerticalStack(layout: Layout().centerHorizontally().top(100), [
                    Label("TODO"),
//                    Label("TODO", style : {
////                        $0.font = UIFont.systemFont(ofSize: 30)
////                        $0.textAlignment = .center
//                    }),
                    HorizontalStack([
                        Field("My Next Thing",
                              text: self.state.newtaskName,
                              textChanged: { [weak self] s in
                                self?.updateState { $0.newtaskName = s }
                              },
                              props: { p in
//                                $0.backgroundColor = .white
//                                $0.becomeFirstResponder()
                        }),
                        Button("Add #\(self.state.items.count+1)",
                               tap: { [weak self] in self?.addItem() }),
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
//    
//    // Test wiht pathcing view hierarchies!
//    func forceRerender() -> Bool {
//        return true
//    }
    
}
