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

protocol UIKitRenderable {
    func uiKitView() -> UIView
}

extension View: UIKitRenderable {
    func uiKitView() -> UIView {
        let v = UIView()
        v.backgroundColor = props.backgroundColor
        v.layer.borderColor = props.borderColor.cgColor
        v.layer.borderWidth = props.borderWidth
        v.layer.cornerRadius = props.cornerRadius
        v.layer.anchorPoint = props.anchorPoint
        v.clipsToBounds = props.clipsToBounds
        v.isUserInteractionEnabled = props.isUserInteractionEnabled
        return v
    }
}

extension Label: UIKitRenderable {
    func uiKitView() -> UIView {
        let l = UILabel()
        l.text = props.text
        l.textColor = props.textColor
        l.font = props.font
        l.numberOfLines = props.numberOfLines
        l.textAlignment = props.textAlignment
        return l
    }
}

extension Field: UIKitRenderable {
    func uiKitView() -> UIView {
        let v = BlockBasedUITextField()
        v.placeholder = props.placeholder
        v.text = props.text
        return v
    }
}

extension TextView: UIKitRenderable {
    func uiKitView() -> UIView {
        let v = BlockBasedUITextView()
        v.text = props.text
        v.backgroundColor = props.backgroundColor
        return v
    }
}

extension Image: UIKitRenderable {
    func uiKitView() -> UIView {
        let v = UIImageView()
        v.image = props.image
        v.contentMode = props.contentMode
        return v
    }
}

extension Switch: UIKitRenderable {
    func uiKitView() -> UIView {
        let v = BlockBasedUISwitch()
        v.isOn = props.isOn
        return v
    }
}

extension Slider: UIKitRenderable {
    func uiKitView() -> UIView {
        let v = BlockBasedUISlider()
        v.value = props.value
        return v
    }
}

extension Progress: UIKitRenderable {
    func uiKitView() -> UIView {
        let v = UIProgressView()
        v.progress = props.progress
        return v
    }
}

extension Map: UIKitRenderable {
    func uiKitView() -> UIView {
        return MKMapView()
    }
}

extension PageControl: UIKitRenderable {
    func uiKitView() -> UIView {
        let v = UIPageControl()
        v.numberOfPages = props.numberOfPages
        v.currentPage = props.currentPage
        v.pageIndicatorTintColor = props.pageIndicatorTintColor
        v.currentPageIndicatorTintColor = props.currentPageIndicatorTintColor
        return v
    }
}

extension ActivityIndicatorView: UIKitRenderable {
    func uiKitView() -> UIView {
        let v = UIActivityIndicatorView(activityIndicatorStyle: props.activityIndicatorStyle)
        v.hidesWhenStopped = true
        if props.isHidden {
            v.stopAnimating()
        } else {
            v.startAnimating()
        }
        return v
    }
}

extension HorizontalStack: UIKitRenderable {
    func uiKitView() -> UIView {
        let v = UIStackView()
        v.axis = .horizontal
        v.spacing = props.spacing
        return v
    }
}

extension VerticalStack: UIKitRenderable {
    func uiKitView() -> UIView {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = props.spacing
        return v
    }
}

extension Button: UIKitRenderable {
    func uiKitView() -> UIView {
        let v = BlockBasedUIButton()
        v.setTitle(props.text, for: .normal)
        v.setTitleColor(props.titleColorForNormalState, for: .normal)
        v.setTitleColor(props.titleColorForHighlightedState, for: .highlighted)
        
        if let backgroundColorForNormalState = props.backgroundColorForNormalState {
            v.setBackgroundColor(backgroundColorForNormalState, for: .normal)
        }
        if let backgroundForHighlightedState = props.backgroundForHighlightedState {
            v.setBackgroundColor(backgroundForHighlightedState, for: .highlighted)
        }
        v.isEnabled = props.isEnabled
        v.titleLabel?.font = props.font
        
        if let bi = props.image {
            v.setBackgroundImage(bi, for: .normal)
        }
        return v
    }
}

extension ScrollView: UIKitRenderable {
    func uiKitView() -> UIView {
        return UIScrollView()
    }
}

extension Table: UIKitRenderable {
    func uiKitView() -> UIView {
        let table = CallBackTableView(frame: CGRect.zero, style: tableStyle)
        table.estimatedRowHeight = 100
        table.rowHeight = UITableViewAutomaticDimension
        
        if let rc = refreshCallback {
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
            return self.data().count
        }
        table.cellForRowAt = { tbv, ip in
            if ip.section == 0 {
                let child = self.data()[ip.row]
                let component = self.configure(child)
                return ComponentCell(component: component)
            }
            return UITableViewCell()
        }
        
        if let deleteCallback = deleteCallback {
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
}
