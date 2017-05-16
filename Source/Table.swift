//
//  Table.swift
//  Komponents
//
//  Created by Sacha Durand Saint Omer on 12/05/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import Foundation

public struct Table: Node, Equatable {
    
    public var uniqueIdentifier: Int = generateUniqueId()
    public var propsHash: Int { return props.hashValue }
    public var children = [IsNode]()
    public let props: TableProps
    public var layout: Layout
    public var ref: UnsafeMutablePointer<UITableView>?
    
    public var cells = [IsComponent]()
    var tableStyle: UITableViewStyle = .plain
    var refreshCallback: (( @escaping EndRefreshingCallback) -> Void)?
    var deleteCallback: ((Int, @escaping ShouldDeleteBlock) -> Void)?
    
    // todo add props.
    public init(
        _ tableStyle: UITableViewStyle = .plain,
        refresh: ((@escaping EndRefreshingCallback) -> Void)? = nil,
        delete: ((Int, @escaping ShouldDeleteBlock) -> Void)? = nil,
        props:((inout TableProps) -> Void)? = nil,
        layout: Layout? = nil,
        ref: UnsafeMutablePointer<UITableView>? = nil,
        cells: [IsComponent]) {
        
        if let p = props {
            var prop = TableProps()
            p(&prop)
            self.props = prop
        } else {
            self.props = TableProps()
        }
        
        self.layout = layout ?? Layout()
        self.ref = ref
        self.children = [IsNode]()
        self.cells = cells
        self.refreshCallback = refresh
        self.deleteCallback = delete
    }
}

public func == (lhs: Table, rhs: Table) -> Bool {
    return lhs.props == rhs.props
        && lhs.layout == rhs.layout
}

public struct TableProps: Equatable, Hashable {
    
    public var tableStyle: UITableViewStyle = .plain

    public var hashValue: Int {
        return tableStyle.hashValue
    }
}

public func == (lhs: TableProps, rhs: TableProps) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
