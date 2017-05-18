//
//  Layout+Autolayout.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 12/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

// Translates the Layout Struct into Autolayout layout anchors :)
func layout(_ newView: UIView, withLayout layout: Layout, inView aView: UIView) {
    
    
    var view = aView
    if let cell = view as? UITableViewCell {
        view  = cell.contentView
    }
    
    
    if layout.isCenteredVertically == true {
        newView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    if layout.isCenteredHorizontally == true {
        newView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    if let top = layout.top {
        newView.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(top)).isActive = true
    }
    if let bottom = layout.bottom {
        newView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat(bottom)).isActive = true
    }
    if let right = layout.right {
        newView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: CGFloat(right)).isActive = true
    }
    if let left = layout.left {
        newView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(left)).isActive = true
    }
    if let height = layout.height {
        newView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
    }
    if let width = layout.width {
        newView.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
    }
}
