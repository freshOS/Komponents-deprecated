//
//  Node+References.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 12/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit
import MapKit

func linkReference(of node: IsNode, to view: UIView) {
    if let node = node as? View {
        node.ref?.pointee = view
    }
    if let node = node as? Label, let view = view as? UILabel {
        node.ref?.pointee = view
    }
    if let node = node as? Button, let view = view as? UIButton {
        node.ref?.pointee = view
    }
    if let node = node as? Field, let view = view as? UITextField {
        node.ref?.pointee = view
    }
    if let node = node as? TextView, let view = view as? UITextView {
        node.ref?.pointee = view
    }
    if let node = node as? Image, let view = view as? UIImageView {
        node.ref?.pointee = view
    }
    if let node = node as? Switch, let view = view as? UISwitch {
        node.ref?.pointee = view
    }
    if let node = node as? Slider, let view = view as? UISlider {
        node.ref?.pointee = view
    }
    if let node = node as? Progress, let view = view as? UIProgressView {
        node.ref?.pointee = view
    }
    if let node = node as? Map, let view = view as? MKMapView {
        node.ref?.pointee = view
    }
    if let node = node as? PageControl, let view = view as? UIPageControl {
        node.ref?.pointee = view
    }
    if let node = node as? ActivityIndicatorView, let view = view as? UIActivityIndicatorView {
        node.ref?.pointee = view
    }
    if let node = node as? HorizontalStack, let view = view as? UIStackView {
        node.ref?.pointee = view
    }
    if let node = node as? VerticalStack, let view = view as? UIStackView {
        node.ref?.pointee = view
    }
    if let node = node as? ScrollView, let view = view as? UIScrollView {
        node.ref?.pointee = view
    }
    if let node = node as? Table, let view = view as? UITableView {
        node.ref?.pointee = view
    }
}
