//
//  DefaultNodesVC.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 01/05/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Stevia
import Komponents

class DefaultNodesVC: UIViewController, StatelessComponent {

    override func loadView() { loadComponent() }
    
    func render() -> Tree {
        title = "Default Nodes"
        return
            View(layout:.fill, [
                VerticalStack(
                    props: { $0.spacing = 5 },
                    layout: .center, [
                    
                    // View
                    View(props: { $0.backgroundColor = .red }, layout: Layout().height(50), []),

                    // Label
                    Label("Label !"),
                    
                    // Field
                    Field("A cool field", textChanged: { print($0) } ),

                    // TextView
                    TextView(text: "Some Text",
                             textChanged: { print($0) },
                             props: { $0.backgroundColor = .lightGray },
                             layout: Layout().size(100)),
                    // Button
                    Button("Button",
                           tap: { print("Tapped!") },
                           props: {
//                                $0.backgroundColor = .yellow
                                $0.setTitleColor(.black, for:.normal)
                                $0.setTitleColor(.gray, for:.highlighted)
                            }
                    ),
                    
                    // Image
                    Image(#imageLiteral(resourceName: "anImage"), props: { $0.contentMode = .scaleAspectFill }),
  
                    // Page Control
                    PageControl(props: {
                        $0.numberOfPages = 5
                        $0.pageIndicatorTintColor = .lightGray
                        $0.currentPageIndicatorTintColor = .gray
                        $0.currentPage = 3
                    }),

                    ActivityIndicatorView(.gray),

                    // Slider
                    Slider(0.5,
                           changed: { print($0) },
                           Layout().width(100)),

                    // Switch
                    Switch(true, changed: { print($0) }),
                    
                    // Progress
                    Progress(0.7),
                    
                    // Map
                    Map(layout: Layout().height(100))
                        
                ])
        ])
    }
}
