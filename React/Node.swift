//
//  Node.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import Foundation

protocol Node:Renderable {
    var children: [Node] { get set }
    var applyStyle: (() -> ())? { get set }
    var applyLayout: (() -> ())? { get set }
}

extension Node {
    func render() -> Renderable {
        return self
    }
}




