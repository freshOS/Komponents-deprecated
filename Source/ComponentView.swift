//
//  ComponentView.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 26/04/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

/// Helper to render a given compoenent in a UIView.
/// By using this wrapper, you can use components incrementally by migrating your UIView subclasses in your App.

public class ComponentView<T: Component> :UIView {
    
    public let component: T!
    
    let engine = WeactEngine()
    
    public init(component: T) {
        self.component = component
        super.init(frame: CGRect.zero)
        engine.render(component:component, in: self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
