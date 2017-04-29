//
//  PhotoComponent.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Stevia
import Weact

class PhotoComponent: Component {
    
    var state = Photo()
    
    func render() -> Node {
        return
            VerticalStack(style: { $0.spacing = 20 }, layout: { $0.centerInContainer() }, [
                Button("Tap Me", tap: { self.updateState { $0.numberOfYummys += 1 } }),
                Label("There"),
                Label("How"),
                Label("Are"),
                Label("\(state.numberOfYummys)")
            ])
    }
}
