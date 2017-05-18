//
//  ComponentView.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 26/04/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

/// Helper to render a given compoenent in a UIView.
/// By using this wrapper, you can use components incrementally by migrating your UIView subclasses in your App.

public class ComponentView<T: IsComponent> :UIView {
    
    public let component: T!
    
    public init(component: T) {
        self.component = component
        super.init(frame: CGRect.zero)
        KomponentsEngine().render(component:component, in: self)
        if let firstSubview = self.subviews.first {
            layout(firstSubview, withLayout: .fill, inView: self)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class ComponentCell: UITableViewCell {
    
    public let component: IsComponent!
    
    public init(component: IsComponent) {
        self.component = component
        super.init(style: .default, reuseIdentifier: "")
        selectionStyle = .none
        let renderer = UIKitRenderer()
        renderer.render(tree: component.render(), in: self)
        component.didRender()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
