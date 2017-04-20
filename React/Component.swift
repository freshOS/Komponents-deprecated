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
    var state: State { get set }
    func render(state: State) -> Node
    func updateState(_ block:(inout State) -> Void)
}

extension Component {
    
    func render() -> Node {
        print(state)
        return render(state: state)
    }
    
    func updateState(_ block:(inout State) -> Void) {
        block(&state)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"WeactStateChanged"), object: nil)
        
    }
}
