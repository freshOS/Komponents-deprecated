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
        weak var weakSelf = self
        return
            Table(.grouped,
                  layout: .fill,
                  data: weakSelf?.fences,
                  refresh: { done in
                    weakSelf?.fakeFetchFences { newFences in
                        weakSelf?.fences = newFences
                        done()
                    }
                  },
                  delete: { index, shouldDelete in
                    weakSelf?.fences.remove(at: index)
                    shouldDelete(true)
                  },
                  configure: { fence in
                    return FenceCell(fence, didActivate: { b in print("did activate \(b) for: \(fence)") })
                  }
        )
    }
    
    func fakeFetchFences(completion:@escaping ([String]) -> Void ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            completion(["fence A", "fence B", "fence C", "fence D"])
        })
    }
    
    deinit {
        print("DEstroy StaticTableVC")
    }
}
