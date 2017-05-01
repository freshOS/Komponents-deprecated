//
//  MyCell.swift
//  WeactExample
//
//  Created by Sacha Durand Saint Omer on 01/05/2017.
//  Copyright © 2017 Octopepper. All rights reserved.
//

import UIKit
import Stevia
import Weact

class MyCell: UITableViewCell, CellComponent {
    
    var isDirty: Bool = false
    
    var props = "Test"
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadComponent()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() -> Node {
        return
            View(style: { $0.backgroundColor = .white },[
                HorizontalStack(
                    style: { $0.spacing = 20 },
                    layout: { $0.fillContainer() }, [
                    Image(#imageLiteral(resourceName: "anImage"), layout: { $0.size(100) }),
                    Label(props)
                ])
            ])
    }
}
