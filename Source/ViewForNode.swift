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

func viewForNode(node: IsNode) -> UIView {
    
    if let node = node as? View {
        let v = UIView()
        v.backgroundColor = node.props.backgroundColor
        v.layer.borderColor = node.props.borderColor.cgColor
        v.layer.borderWidth = node.props.borderWidth
        v.layer.cornerRadius = node.props.cornerRadius
        v.layer.anchorPoint = node.props.anchorPoint
        v.clipsToBounds = node.props.clipsToBounds
        v.isUserInteractionEnabled = node.props.isUserInteractionEnabled
        return v
    }
    
    if let node = node as? Label {
        let l = UILabel()
        l.text = node.props.text
        l.textColor = node.props.textColor
        l.font = node.props.font
        l.numberOfLines = node.props.numberOfLines
        l.textAlignment = node.props.textAlignment
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
    
    if node is Map {
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
        v.hidesWhenStopped = true
        if node.props.isHidden {
            v.stopAnimating()
        } else {
            v.startAnimating()
        }
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
        
        if let backgroundColorForNormalState = node.props.backgroundColorForNormalState {
            v.setBackgroundColor(backgroundColorForNormalState, for: .normal)
        }
        if let backgroundForHighlightedState = node.props.backgroundForHighlightedState {
            v.setBackgroundColor(backgroundForHighlightedState, for: .highlighted)
        }
        v.isEnabled = node.props.isEnabled
        v.titleLabel?.font = node.props.font
        
        if let bi = node.props.image {
            v.setBackgroundImage(bi, for: .normal)
        }
        return v
    }
    
    if node is ScrollView {
        let v = UIScrollView()
        return v
    }
    
    if let node = node as? Table {
        let table = CallBackTableView(frame: CGRect.zero, style: node.tableStyle)
        table.estimatedRowHeight = 100
        table.rowHeight = UITableViewAutomaticDimension
        
        if let rc = node.refreshCallback {
            let refreshControl = BlockBasedUIRefreshControl()
            table.addSubview(refreshControl)
            let newRefreshCallback: ( ( @escaping EndRefreshingCallback) -> Void) = { done in
                rc {
                    done()
                    table.reloadData()
                    
                }
            }
            refreshControl.setCallback(newRefreshCallback)
        }
        
        table.numberOfRows = {
            return node.data().count
        }
        table.cellForRowAt = { tbv, ip in
            if ip.section == 0 {
                let child = node.data()[ip.row]
                let component = node.configure(child)
                return ComponentCell(component: component)
            }
            return UITableViewCell()
        }
        
        if let deleteCallback = node.deleteCallback {
            table.didDeleteRowAt = { ip in
                let shouldDeleteBlock = { (b: Bool) in
                    if b {
                        // Remove cell
//                        node.cells().remove(at: ip.row)
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
