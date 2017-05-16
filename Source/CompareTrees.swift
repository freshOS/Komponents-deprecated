//
//  CompareTrees.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 11/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

func areTreesEqual(_ tree: Tree, _ otherTree: Tree) -> Bool {
    var areOfTheSameType = false
    var haveTheSameProps = false
    var haveTheSameLayout = false
    var haveTheSameChildren = false
    
    if type(of: tree) == type(of: otherTree) { // Compare types
        areOfTheSameType = true
        haveTheSameLayout = tree.layout == otherTree.layout
        haveTheSameProps = tree.propsHash == otherTree.propsHash// Compare props
        if tree.children.count != otherTree.children.count { // Same children count?
            haveTheSameChildren = false
            return false // early return optim?
        } else {
            haveTheSameChildren = true
            for i in tree.children.indices {
                let treeChild = tree.children[i]
                let otherTreeChild = otherTree.children[i]
                if !areTreesEqual(treeChild, otherTreeChild) {
                    haveTheSameChildren = false
                    break
                }
            }
        }
    }
    
    return areOfTheSameType
        && haveTheSameProps
        && haveTheSameLayout
        && haveTheSameChildren
}
