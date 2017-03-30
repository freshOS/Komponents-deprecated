//
//  PhotoFeedCell.swift
//  React
//
//  Created by Sacha Durand Saint Omer on 29/03/2017.
//  Copyright © 2017 Freshos. All rights reserved.
//

import Stevia

struct PhotoFeedCell {
    
    static func new(with photo: Photo) -> Component {
        return VerticalStack(style: {
            $0.spacing = 30
            $0.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
            $0.isLayoutMarginsRelativeArrangement = true
        }, children:
                    FeedTopComponent.new(with: photo),
                    PhotoView.with(url: URL(string: "http://google.com")),
                    FeedBottomComponent.new(with: photo)
                )
    }
}

// 

struct Avatar {
    static func new() -> Component {
        return View(
            style: {
                $0.backgroundColor = .gray
                $0.clipsToBounds = true
                $0.layer.cornerRadius = 25
        },
            layout: { $0.size(50) })
    }
}

struct PhotoView {
    static func with(url:URL?) -> Component {
        return View(
            style: {
                $0.backgroundColor = .gray
        },
            layout: {
                |$0|
                $0.heightEqualsWidth()
        })
    }
}

struct FeedTopComponent {
    
    static func new(with post: Post) -> Component {
        
        return View(style: { $0.backgroundColor = .white },
                    children:
            VerticalStack(
                style: {
                    $0.spacing = 10
                    $0.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
                    $0.isLayoutMarginsRelativeArrangement = true
            },
                layout: { $0.fillContainer() }, children:
                HorizontalStack(style: { $0.spacing = 10 }, children:
                    Avatar.new(), VerticalStack(children:
                        Text(post.title),
                        Text(post.detail)
                    )
                ),
                Text("THIS IS A LONG DESCRIPTION")
            )
        )
    }
}

struct FeedBottomComponent {
    
    static func new(with post: Post) -> Component {
        return View(children:
            HorizontalStack(style: { $0.spacing = 20 }, layout: { |-20-$0.fillVertically() }, children:
                Button(image: #imageLiteral(resourceName: "FeedYummyIcon"), tap: { print("Yummied!!!!! Tapppppppped") }),
                Text("\(post.numberOfYummys)"),
                Button(image: #imageLiteral(resourceName: "Comment icon")),
                Text("\(post.numberOfcomments)")
            ),
            Button(image: #imageLiteral(resourceName: "More"), layout: { $0.fillVertically()-20-| } )
        )
    }
}
