//
//  Node.swift
//  Weact
//
//  Created by Sacha Durand Saint Omer on 30/03/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import Foundation
import UIKit




protocol Node:Renderable {
//    var layoutBlock: ((Any) -> ())? { get set }
//    var styleBlock: ((Any) -> ())? { get set }
    var children: [Node] { get set }
    
    
    var applyStyle: (() -> ())? { get set }
    var applyLayout: (() -> ())? { get set }
}


extension Node {
    func render() -> Renderable {
        return self
    }
}

struct View: Node {
    
    var applyStyle: (() -> ())?
    var applyLayout: (() -> ())?
    var layoutBlock: ((UIView) -> ())?
    var styleBlock: ((UIView) -> ())?
    var children = [Node]()
    
    init(style:((UIView)->())? = nil, layout:((UIView)->())? = nil , _ children:[Node]) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
    }
}

struct Text: Node {
    
    var applyStyle: (() -> ())?
    var applyLayout: (() -> ())?
    var layoutBlock: ((UILabel) -> ())?
    var styleBlock: ((UILabel) -> ())?
    var children = [Node]()
    var wording = ""
    
    init(_ wording: String = "", style:((UILabel)->())? = nil, layout:((UILabel)->())? = nil , children:[Node] = [Node]() ) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
        self.wording = wording
    }
}


struct VerticalStack: Node {
    
    var applyStyle: (() -> ())?
    var applyLayout: (() -> ())?
    var layoutBlock: ((UIStackView) -> ())?
    var styleBlock: ((UIStackView) -> ())?
    var children = [Node]()
    
    init(style:((UIStackView)->())? = nil, layout:((UIStackView)->())? = nil , children:[Node] = [Node]() ) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
    }
    
    init(style:((UIStackView)->())? = nil, layout:((UIStackView)->())? = nil , _ children: [Node]) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
    }
}

struct HorizontalStack: Node {
    
    var applyStyle: (() -> ())?
    var applyLayout: (() -> ())?
    var layoutBlock: ((UIStackView) -> ())?
    var styleBlock: ((UIStackView) -> ())?
    var children = [Node]()
    
    init(style:((UIStackView)->())? = nil, layout:((UIStackView)->())? = nil , children:[Node] = [Node]() ) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
    }
    
    init(style:((UIStackView)->())? = nil, layout:((UIStackView)->())? = nil , _ children: [Node]) {
        self.layoutBlock = layout
        self.styleBlock = style
        self.children = children
    }
}


class Button: Node {
    
    var tapCallback:(() -> Void)?
    
    var applyStyle: (() -> ())?
    var applyLayout: (() -> ())? 
    var layoutBlock: ((UIButton) -> ())?
    var styleBlock: ((UIButton) -> ())?
    var children = [Node]()
    var wording = ""
    var image:UIImage?
    
    var registerTap: ((UIButton) -> ())?
    

    init(_ wording: String = "", image: UIImage? = nil, tap: (() -> Void)? = nil, style:((UIButton)->())? = nil, layout:((UIButton)->())? = nil) {
        self.image = image
        self.wording = wording
        self.layoutBlock = layout
        self.styleBlock = style
        tapCallback = tap
        
        tapCallback = tap
        
        registerTap = { b in
            b.addTarget(self, action: #selector(self.didTap), for: .touchUpInside)
        }
    }
    
    @objc func didTap() {
        tapCallback?()
    }
}



