//
//  TodoVC.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 01/05/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Komponents

class TodoVC: UIViewController, Component {
    
    struct State {
        var items = [Item]()
        var newtaskName = ""
    }
    
    struct Item {
        let name: String
        let time: Date
    }
    
    var state = State()
    
    var reactEngine: KomponentsEngine?

    override func loadView() { loadComponent() }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Todo"
    }
    
    func render() -> Tree {
        return
            View([
                VerticalStack(layout: Layout().centerHorizontally().top(100), [
                    HorizontalStack([
                        Field("My Next Thing",
                              text: self.state.newtaskName,
                              textChanged: { [weak self] s in self?.updateState { $0.newtaskName = s }
                        }),
                        Button("Add #\(self.state.items.count+1)",
                               tap: { [weak self] in self?.addItem() },
                               props: { $0.setTitleColor(.red, for: .normal)
                        })
                    ]),
                    VerticalStack(
                        self.state.items.map { item in
                            HorizontalStack([
                                Label("- \(item.name)"),
                                Button("X",
                                       tap: { [weak self] in self?.removeItem(item) },
                                       props: { $0.setTitleColor(.red, for: .normal) }
                                )
                            ])
                        }
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
    
    func removeItem(_ item: Item) {
        if let index = state.items.index(where: { $0.name == item.name }) {
            updateState {
                $0.items.remove(at: index)
            }
        }
    }
}
