//
//  Component.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 31/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import Foundation

protocol Component:class, Renderable {
    
    associatedtype State
    var state: State! { get set }
    func render(state: State) -> Node
    func updateState(_ block:(inout State!) -> Void)
    func initialState() -> State!
}

extension Component {
    
    func render() -> Node {
        print(state)
        return render(state: state)
    }
    
    func updateState(_ block:(inout State!) -> Void) {
        block(&state)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"WeactStateChanged"), object: nil)
    }
}


import UIKit

class CustomComponent<State>: Component {
    
    var state: State!
    
    init() {
        state = self.initialState()
    }
    
    func render(state: State) -> Node {
        return View([])
    }
    
    func initialState() -> State! {
        return nil
    }
}

protocol WeactComponent: Component {
    
}
