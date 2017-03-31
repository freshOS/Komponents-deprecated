//
//  PhotoComponent.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import Foundation
import Stevia

struct PhotoComponent: Component {  //: AComponent {
    
    var state: Photo = Photo()
    
    func render(state: Photo) -> Node {
        return
            VerticalStack(style: { $0.spacing = 50 }, layout: { $0.centerInContainer() }, [
                Button("Tap Me", tap: {
                    print("HELL YEAAAH")
                }),
                Text("There"),
                Text("How"),
                Text("Are"),
                Text("\(state.title)")
            ])
    }
}



//
struct FeedBottomComponent2: Component {
    
    var state: Post = Photo()
    
    func render(state post: Post) -> Node {
        return
            View([
                HorizontalStack(style: { $0.spacing = 20 }, layout: { |-20-$0.fillVertically() }, [
                    Button(image: #imageLiteral(resourceName: "FeedYummyIcon"), tap: { print("Yummied!!!!! Tapppppppped") }),
                    Text("\(post.numberOfYummys)"),
                    Button(image: #imageLiteral(resourceName: "Comment icon")),
                    Text("\(post.numberOfcomments)")
                    ]),
                Button(image: #imageLiteral(resourceName: "More"), layout: {
                    $0.fillVertically()-20-|
                } )
            ])
    }
}

