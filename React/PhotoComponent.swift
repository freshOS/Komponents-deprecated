//
//  PhotoComponent.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import Foundation
import Stevia

class PhotoComponent: Component {
    
    var state: Photo = Photo()
    
    func render(state photo: Photo) -> Renderable {
        
        return
            VerticalStack(style: { $0.spacing = 50 }, layout: { $0.centerInContainer() }, [
                Button("Tap Me", tap: { self.updateState { $0.numberOfYummys += 1} }),
                Text("There"),
                Text("How"),
                Text("Are"),
                Text("\(photo.numberOfYummys)")
            ])
    }
}
