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
    
    func render() -> Node {
        title = "Default Nodes"
        return
            View(style: { $0.backgroundColor = .white }, [
                VerticalStack(
                    style: { $0.spacing = 5 },
                    layout: { $0.centerInContainer() }, [
                    
                    // View
                    View(style: { $0.backgroundColor = .red }, layout: { $0.height(50) }),
                    
                    // Label
                    Label("Label !"),
                    
                    // Field
                    Field("A cool field", textChanged: { print($0) } ),
                    
                    TextView("Some Text",
                             textChanged: { print($0) },
                             style: { $0.backgroundColor = .lightGray },
                             layout: { $0.size(100) }),
                    
                    // Button
                    Button("Button",
                           tap: { print("Tapped!") },
                           style: {
                                $0.backgroundColor = .yellow
                                $0.setTitleColor(.black, for:.normal)
                                $0.setTitleColor(.gray, for:.highlighted)
                            }
                    ),
                    
                    // Image
                    Image(#imageLiteral(resourceName: "anImage"), style: {
                        $0.contentMode = .scaleAspectFill
                    }),
                    
                    // Page Control
                    PageControl(style: {
                        $0.numberOfPages = 5
                        $0.pageIndicatorTintColor = .lightGray
                        $0.currentPageIndicatorTintColor = .gray
                        $0.currentPage = 3
                    }),
                    
                    ActivityIndicatorView(),
                    
                    // Slider
                    Slider(0.5,
                           changed: { print($0) },
                           // changed: (#selector(changed), target: self),
                           layout: { $0.width(100) }),
                    
                    // Switch
                    Switch(true, changed: { print($0) }),
                    Progress(0.7)
                ])
        ])
    }
    
//    func changed(s:UISwitch) {
//        print("SWITCH CHANGED!!! \(s.isOn)")
//    }
    
    deinit {
        print("deinit VC")
    }
}
