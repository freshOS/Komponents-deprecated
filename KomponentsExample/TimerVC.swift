//
//  Timer.swift
//  KomponentsExample
//
//  Created by Sacha Durand Saint Omer on 30/04/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Stevia
import Komponents

class TimerVC: UIViewController, Component {
    
    var reactEngine: KomponentsEngine?
    var state = 0
    
    override func loadView() { loadComponent() }
    
    var timer: Timer?
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
           timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    func tick() {
        updateState{
            if $0 == 0 {
                $0 = 1
            } else {
                $0 = 0
            }
        }
    }
    
    func render() -> Tree {
        title = "Timer"
        return
            View(layout: .fill, [
                Label("\(self.state)", layout: .center)
            ])
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    func enablePatching() -> Bool {
        return true
    }
}
