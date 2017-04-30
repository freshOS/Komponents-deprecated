//
//  WeactEngine.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Stevia
import UIKit

public class WeactEngine {
    
    static let shared = WeactEngine()
    
    
    // retain non-VC components here
    var componentsMap = [String: IsComponent]()
    var viewMap = [String: UIView]()
    
    func viewForComponentId(_ id :String) -> UIView {
        return viewMap[id]!
    }
    
    private convenience init() {
        self.init(renderer:UIKitRenderer())
    }
    
    let renderer: Renderer
    private init(renderer: Renderer) {
        self.renderer = renderer
        NotificationCenter.default
            .addObserver(forName: NSNotification.Name(rawValue:"WeactStateChanged"),
                         object: nil,
                         queue: nil) { [unowned self] n in
                if let componentToUpdate = n.object as? IsComponent {
                    self.updateComponent(componentToUpdate)
                }
            }
    }
    
    private func updateComponent(_ component: IsComponent) {
        // VC Component
        if let vc = component as? UIViewController {
            for sv in vc.view.subviews {
                sv.removeFromSuperview()
            }
            // Re-render compoenent in superview.
            self.renderer.render(component, in: vc.view, withEngine: self, atIndex: nil)
            
        } else {
            // Non-VC Component
            let associatedView = self.viewForComponentId(component.uniqueIdentifier)
            if let superview = associatedView.superview {
                var stackViewIndex: Int?
                if let stackView = superview as? UIStackView {
                    stackViewIndex = stackView.arrangedSubviews.index(of: associatedView)
                }
                // Remove previous view hierarchy.
                associatedView.removeFromSuperview()
                // Re-render compoenent in superview.
                self.renderer.render(component, in: superview, withEngine: self, atIndex: stackViewIndex)
            }
        }
    }
    
    public func render<C: IsComponent>(component: C, in view: UIView) {
        renderer.render(component, in: view, withEngine: self, atIndex: nil)
    }
}
