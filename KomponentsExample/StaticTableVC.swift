//
//  StaticTableVC.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 08/05/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Komponents

public extension UIColor {
    
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}

class StaticTableVC: UIViewController, StatelessComponent {
    
    var fences = ["fence 1", "fence 2", "A cool 3"]
    
    override func loadView() { loadComponent() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Static Table"
    }
    
    func render() -> Tree {
        return
            Table(.grouped,
                  layout: .fill,
                  data: self.fences,
                  refresh: refresh,
                  delete: delete,
                  configure : configure
        )
    }
    
    func refresh(_ done: @escaping () -> Void ) {
        print("Refreshing...")
        fences = ["fence A", "fence B", "fence C", "fence D"]
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            done()
        })
    }
    
    func delete(index: Int, shouldDelete: ((Bool) -> Void)) {
        print("Deleting...")
        fences.remove(at: index)
        shouldDelete(true)
    }
    
    func configure(fence: String) -> IsComponent {
        return FenceCell(fence, didActivate: { b in print("did activate \(b) for: \(fence)") })
    }
}

//                  style: { $0.separatorStyle = .none },
