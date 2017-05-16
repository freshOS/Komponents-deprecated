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
    var timer: Timer?
    
    override func loadView() { loadComponent() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Timer"
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
           timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    func render() -> Tree {
        return
            View([
                Label("\(self.state)", layout: .center)
            ])
    }
    
    func tick() {
        updateState { $0 += 1 }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
}
