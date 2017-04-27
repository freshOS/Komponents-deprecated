//
//  Node.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import Foundation

public protocol Node: Renderable {
    var children: [Node] { get set }
    var applyStyle: (() -> Void)? { get set }
    var applyLayout: (() -> Void)? { get set }
}

extension Node {
    public func render() -> Node {
        return self
    }
}
