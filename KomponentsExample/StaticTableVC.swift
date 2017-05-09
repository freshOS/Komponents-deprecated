//
//  StaticTableVC.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 08/05/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Stevia
import Komponents

public extension UIColor {
    
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}


class StaticTableVC: UIViewController, StatelessComponent {
    
    override func loadView() { loadComponent() }
    
    func render() -> Node {
        let fences = ["fence 1", "fence 2", "A cool 3"]
        title = "Static Table"
        return
            Table(.grouped, refresh: refresh, style: { $0.separatorStyle = .none },
                  fences.map {
                    FenceCell(fence, didActivate: { b in print("did activate \(b) for: \(fence)") })
                }
            )
    }
    
    func refresh(_ done: @escaping () -> Void ) {
        print("Refreshing...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute:{
            done()
        })
        
    }
}

