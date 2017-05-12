//
//  Map.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 12/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation
import MapKit

public struct Map: Node, Equatable {
    
    public let uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public var children = [IsNode]()
    public let props: MapProps
    public let layout: Layout
    public var ref: UnsafeMutablePointer<MKMapView>?
    
    // todo add props.
    public init(
        props:((inout MapProps) -> Void)? = nil,
        layout: Layout? = nil,
        ref: UnsafeMutablePointer<MKMapView>? = nil) {
        if let p = props {
            var prop = MapProps()
            p(&prop)
            self.props = prop
        } else {
            self.props = MapProps()
        }
        self.layout = layout == nil ? Layout() : layout!
        self.ref = ref
        self.children = [IsNode]()
    }
}

public func == (lhs: Map, rhs: Map) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

public struct MapProps: Equatable, Hashable {
    
    public var hashValue: Int {
        return 0
    }
}

public func == (lhs: MapProps, rhs: MapProps) -> Bool {
    return true
}
