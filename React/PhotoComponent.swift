//
//  PhotoComponent.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import Stevia

class PhotoComponent: Component {
    
    var state: Photo = Photo()
    
    func render(state photo: Photo) -> Node {
        return
            VerticalStack(style: { $0.spacing = 20 }, layout: { $0.centerInContainer() }, [
                Button("Tap Me", tap: { self.updateState { $0.numberOfYummys += 1} }),
                Text("There"),
                Text("How"),
                Text("Are"),
                Text("\(photo.numberOfYummys)")
            ])
    }
}

// Can use global funcs that return the underlying

func verticalStack(style:((UIStackView)->())? = nil, layout:((UIStackView)->())? = nil , _ children: [Node]) -> VerticalStack {
    var o = VerticalStack()
    o.layoutBlock = layout
    o.styleBlock = style
    o.children = children
    return o
}
