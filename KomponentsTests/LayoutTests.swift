//
//  LayoutTests.swift
//  Komponents
//
//  Created by Sacha DSO on 08/06/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import XCTest

class LayoutTests: XCTestCase {
    
    func testLayout() {
        let l = Layout()
        
        XCTAssertNil(l.top)
        XCTAssertNil(l.right)
        XCTAssertNil(l.bottom)
        XCTAssertNil(l.left)
        XCTAssertNil(l.width)
        XCTAssertNil(l.height)
        XCTAssertNil(l.isCenteredHorizontally)
        XCTAssertNil(l.isCenteredVertically)
    }
    
}
