//
//  Timer.swift
//  WeactExample
//
//  Created by Sacha Durand Saint Omer on 30/04/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Stevia
import Weact

class TimerVC: UIViewController, Component {
    
    var state = 0
    
    override func loadView() { loadComponent() }
    
    var timer: Timer?
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
           timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    func tick() {
        updateState{ $0 += 1 }
    }
    
    func render() -> Node {
        title = "Timer"
        return
            View(style: { $0.backgroundColor = .white }, [
                Label("\(self.state)", layout: { $0.centerInContainer() })
            ])
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
}
