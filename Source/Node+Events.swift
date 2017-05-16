//
//  Node+Events.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 12/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation
import UIKit

func plugEvents(from tree: IsNode, to newView: UIView) {
    if let bNode = tree as? Button {
        bNode.registerTap?(newView as! UIButton)
    }
    if let switchNode = tree as? Switch {
        switchNode.registerValueChanged?(newView as! UISwitch)
    }
    if let sliderNode = tree as? Slider {
        sliderNode.registerValueChanged?(newView as! UISlider)
    }
    if let fieldNode = tree as? Field {
        fieldNode.registerTextChanged?(newView as! UITextField)
    }
    if let fieldNode = tree as? TextView {
        fieldNode.registerTextChanged?(newView as! UITextView)
    }
}
