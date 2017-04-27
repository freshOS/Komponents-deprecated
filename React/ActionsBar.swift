//
//  ActionsBar.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 31/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import Stevia
import Weact

class ActionsBar: Component {
    
    var state = Photo()
    
    func render() -> Node {
        return
            View(
                layout: { |$0.height(100)|.centerVertically() }, [
                HorizontalStack(
                    style: { $0.spacing = 20 },
                    layout: { |-20-$0.fillVertically() }, [
                    Button(
                        image:#imageLiteral(resourceName: "FeedYummyIcon"),
                        tap: {
                                self.updateState {
                                    $0.numberOfYummys += 1
                                    $0.isYummied = true
                                }
                        },
                        style: { $0.backgroundColor = self.state.isYummied ? .green : .clear }
                    ),
                    Label("\(self.state.numberOfYummys)"),
                    Button(image: #imageLiteral(resourceName: "Comment icon"), tap: { print("navigate to Comments view") }),
                    Label("\(self.state.numberOfcomments)")
                ]),
                Button(
                    image: #imageLiteral(resourceName: "More"),
                    tap: { print("show More sheet") },
                    layout: { $0.fillVertically()-20-| }
                )
            ])
    }
}
