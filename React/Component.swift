//
//  Component.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 31/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import Foundation
import UIKit



// TODO stateless component ?

protocol Component:class, Renderable {
    
    associatedtype State
    var state: State { get set }
    func updateState(_ block:(inout State) -> Void)
    func size() -> CGSize
}

extension Component {
 
    func updateState(_ block:(inout State) -> Void) {
        print(state)
        block(&state)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"WeactStateChanged"), object: nil)
    }
    
    func size() -> CGSize {
        return CGSize.zero
    }
}
