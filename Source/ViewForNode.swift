//
//  ViewForNode.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 12/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation
import UIKit
import MapKit

func viewForNode(node:IsNode) -> UIView {
    
    if let node = node as? View {
        let v = UIView()
        v.backgroundColor = node.props.backgroundColor
        v.layer.borderColor = node.props.borderColor.cgColor
        v.layer.borderWidth = node.props.borderWidth
        v.layer.cornerRadius = node.props.cornerRadius
        v.layer.anchorPoint = node.props.anchorPoint
        return v
    }
    
    if let node = node as? Label {
        let l = UILabel()
        l.text = node.props.text
        return l
    }
    
    if let node = node as? Field {
        let v = BlockBasedUITextField()
        v.placeholder = node.props.placeholder
        v.text = node.props.text
        return v
    }
    
    if let node = node as? TextView {
        let v = BlockBasedUITextView()
        v.text = node.props.text
        v.backgroundColor = node.props.backgroundColor
        return v
    }
    
    if let node = node as? Image {
        let v = UIImageView()
        v.image = node.props.image
        v.contentMode = node.props.contentMode
        return v
    }
    
    if let node = node as? Switch {
        let v = BlockBasedUISwitch()
        v.isOn = node.props.isOn
        return v
    }
    
    if let node = node as? Slider {
        let v = BlockBasedUISlider()
        v.value = node.props.value
        return v
    }
    
    if let node = node as? Progress {
        let v = UIProgressView()
        v.progress = node.props.progress
        return v
    }
    
    if let node = node as? Map {
        let v = MKMapView()
        return v
    }
    
    if let node = node as? PageControl {
        let v = UIPageControl()
        v.numberOfPages = node.props.numberOfPages
        v.currentPage = node.props.currentPage
        v.pageIndicatorTintColor = node.props.pageIndicatorTintColor
        v.currentPageIndicatorTintColor = node.props.currentPageIndicatorTintColor
        return v
    }
    
    if let node = node as? ActivityIndicatorView {
        let v = UIActivityIndicatorView(activityIndicatorStyle: node.props.activityIndicatorStyle)
        v.startAnimating()
        return v
    }
    
    if let node = node as? HorizontalStack {
        let v = UIStackView()
        v.axis = .horizontal
        v.spacing = node.props.spacing
        return v
    }
    if let node = node as? VerticalStack {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = node.props.spacing
        return v
    }
    
    if let node = node as? Button {
        let v = BlockBasedUIButton()
        v.setTitle(node.props.text, for: .normal)
        v.setTitleColor(node.props.titleColorForNormalState, for: .normal)
        v.setTitleColor(node.props.titleColorForHighlightedState, for: .highlighted)
        return v
    }
    
    if let node = node as? ScrollView {
        let v = UIScrollView()
        return v
    }
    
    if var node = node as? Table {
        let table = CallBackTableView(frame: CGRect.zero, style: node.tableStyle)
        table.estimatedRowHeight = 100
        
        if let rc = node.refreshCallback {
            let refreshControl = BlockBasedUIRefreshControl()
            table.addSubview(refreshControl)
            refreshControl.setCallback(rc)
        }
        
        table.numberOfRows = {
            return node.cells.count
        }
        table.cellForRowAt = { tbv, ip in
            if ip.section == 0 {
                let child = node.cells[ip.row]
                return ComponentCell(component: child)
            }
            return UITableViewCell()
        }
        
        if let deleteCallback = node.deleteCallback {
            table.didDeleteRowAt = { ip in
                let shouldDeleteBlock = { (b:Bool) in
                    if b {
                        // Remove cell
                        node.cells.remove(at: ip.row)
                        // Delete corresponding row.
                        table.deleteRows(at: [ip], with: .none)
                    } else {
                        table.reloadRows(at: [ip], with: .none)
                    }
                }
                deleteCallback(ip.row, shouldDeleteBlock)
            }
        }
        return table
    }
    
    return UIView()
}
