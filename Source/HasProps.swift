//
//  HasProps.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 11/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

protocol HasProps {
    associatedtype Props: Equatable
    var props: Props { get }
}
