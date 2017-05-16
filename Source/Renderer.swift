//
//  Renderer.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 31/03/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

protocol Renderer {
    func render(_ renderable: Renderable,
                in rootView: UIView,
                withEngine: KomponentsEngine,
                atIndex: Int?,
                ignoreRefs: Bool)
}
