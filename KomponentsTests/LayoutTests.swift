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
    
    func testLayoutTop() {
        let l = Layout().top(150)
        XCTAssertEqual(l.top, 150)
        XCTAssertNil(l.right)
        XCTAssertNil(l.bottom)
        XCTAssertNil(l.left)
        XCTAssertNil(l.width)
        XCTAssertNil(l.height)
        XCTAssertNil(l.isCenteredHorizontally)
        XCTAssertNil(l.isCenteredVertically)
    }
    
    func testLayoutRight() {
        let l = Layout().right(78)
        XCTAssertNil(l.top)
        XCTAssertEqual(l.right, -78)
        XCTAssertNil(l.bottom)
        XCTAssertNil(l.left)
        XCTAssertNil(l.width)
        XCTAssertNil(l.height)
        XCTAssertNil(l.isCenteredHorizontally)
        XCTAssertNil(l.isCenteredVertically)
    }
    
    func testLayoutBottom() {
        let l = Layout().bottom(42)
        XCTAssertNil(l.top)
        XCTAssertNil(l.right)
        XCTAssertEqual(l.bottom, -42)
        XCTAssertNil(l.left)
        XCTAssertNil(l.width)
        XCTAssertNil(l.height)
        XCTAssertNil(l.isCenteredHorizontally)
        XCTAssertNil(l.isCenteredVertically)
    }
    
    func testLayoutLeft() {
        let l = Layout().left(89)
        XCTAssertNil(l.top)
        XCTAssertNil(l.right)
        XCTAssertNil(l.bottom)
        XCTAssertEqual(l.left, 89)
        XCTAssertNil(l.width)
        XCTAssertNil(l.height)
        XCTAssertNil(l.isCenteredHorizontally)
        XCTAssertNil(l.isCenteredVertically)
    }
    
    func testLayoutWidth() {
        let l = Layout().width(123)
        XCTAssertNil(l.top)
        XCTAssertNil(l.right)
        XCTAssertNil(l.bottom)
        XCTAssertNil(l.left)
        XCTAssertEqual(l.width, 123)
        XCTAssertNil(l.height)
        XCTAssertNil(l.isCenteredHorizontally)
        XCTAssertNil(l.isCenteredVertically)
    }
    
    func testLayoutHeight() {
        let l = Layout().height(38)
        XCTAssertNil(l.top)
        XCTAssertNil(l.right)
        XCTAssertNil(l.bottom)
        XCTAssertNil(l.left)
        XCTAssertNil(l.width)
        XCTAssertEqual(l.height, 38)
        XCTAssertNil(l.isCenteredHorizontally)
        XCTAssertNil(l.isCenteredVertically)
    }
    
    func testLayoutCenterHorizontally() {
        let l = Layout().centerHorizontally()
        XCTAssertNil(l.top)
        XCTAssertNil(l.right)
        XCTAssertNil(l.bottom)
        XCTAssertNil(l.left)
        XCTAssertNil(l.width)
        XCTAssertNil(l.height)
        XCTAssertEqual(l.isCenteredHorizontally, true)
        XCTAssertNil(l.isCenteredVertically)
    }
    
    func testLayoutCenterVertically() {
        let l = Layout().centerVertically()
        XCTAssertNil(l.top)
        XCTAssertNil(l.right)
        XCTAssertNil(l.bottom)
        XCTAssertNil(l.left)
        XCTAssertNil(l.width)
        XCTAssertNil(l.height)
        XCTAssertNil(l.isCenteredHorizontally)
        XCTAssertEqual(l.isCenteredVertically, true)
    }
    
    func testLayoutCentered() {
        let l = Layout().centered()
        XCTAssertNil(l.top)
        XCTAssertNil(l.right)
        XCTAssertNil(l.bottom)
        XCTAssertNil(l.left)
        XCTAssertNil(l.width)
        XCTAssertNil(l.height)
        XCTAssertEqual(l.isCenteredHorizontally, true)
        XCTAssertEqual(l.isCenteredVertically, true)
    }
    
    func testLayoutSize() {
        let l = Layout().size(278)
        XCTAssertNil(l.top)
        XCTAssertNil(l.right)
        XCTAssertNil(l.bottom)
        XCTAssertNil(l.left)
        XCTAssertEqual(l.width, 278)
        XCTAssertEqual(l.height, 278)
        XCTAssertNil(l.isCenteredHorizontally)
        XCTAssertNil(l.isCenteredVertically)
    }
    
    func testLayoutFillHorizontally() {
        let l = Layout().fillHorizontally()
        XCTAssertNil(l.top)
        XCTAssertEqual(l.right, 0)
        XCTAssertNil(l.bottom)
        XCTAssertEqual(l.left, 0)
        XCTAssertNil(l.width)
        XCTAssertNil(l.height)
        XCTAssertNil(l.isCenteredHorizontally)
        XCTAssertNil(l.isCenteredVertically)
    }
    
    func testLayoutFillHorizontallyPadding() {
        let l = Layout().fillHorizontally(padding: 73)
        XCTAssertNil(l.top)
        XCTAssertEqual(l.right, -73)
        XCTAssertNil(l.bottom)
        XCTAssertEqual(l.left, 73)
        XCTAssertNil(l.width)
        XCTAssertNil(l.height)
        XCTAssertNil(l.isCenteredHorizontally)
        XCTAssertNil(l.isCenteredVertically)
    }
    
    func testLayoutFillVertically() {
        let l = Layout().fillVertically()
        XCTAssertEqual(l.top, 0)
        XCTAssertNil(l.right)
        XCTAssertEqual(l.bottom, 0)
        XCTAssertNil(l.left)
        XCTAssertNil(l.width)
        XCTAssertNil(l.height)
        XCTAssertNil(l.isCenteredHorizontally)
        XCTAssertNil(l.isCenteredVertically)
    }
    
    func testLayoutFillVerticallyPadding() {
        let l = Layout().fillVertically(padding: 19)
        XCTAssertEqual(l.top, 19)
        XCTAssertNil(l.right)
        XCTAssertEqual(l.bottom, -19)
        XCTAssertNil(l.left)
        XCTAssertNil(l.width)
        XCTAssertNil(l.height)
        XCTAssertNil(l.isCenteredHorizontally)
        XCTAssertNil(l.isCenteredVertically)
    }
    
    func testLayoutFill() {
        let l = Layout().fill()
        XCTAssertEqual(l.top, 0)
        XCTAssertEqual(l.right, 0)
        XCTAssertEqual(l.bottom, 0)
        XCTAssertEqual(l.left, 0)
        XCTAssertNil(l.width)
        XCTAssertNil(l.height)
        XCTAssertNil(l.isCenteredHorizontally)
        XCTAssertNil(l.isCenteredVertically)
    }
    
    func testLayoutFillPadding() {
        let l = Layout().fill(padding: 91)
        XCTAssertEqual(l.top, 91)
        XCTAssertEqual(l.right, -91)
        XCTAssertEqual(l.bottom, -91)
        XCTAssertEqual(l.left, 91)
        XCTAssertNil(l.width)
        XCTAssertNil(l.height)
        XCTAssertNil(l.isCenteredHorizontally)
        XCTAssertNil(l.isCenteredVertically)
    }
    
    // Test equality
    
    func testLayoutEquality() {
        XCTAssertTrue(Layout() == Layout())
        
        // Top
        XCTAssertTrue(Layout().top(10) == Layout().top(10))
        XCTAssertFalse(Layout().top(10) == Layout().top(23))
        XCTAssertFalse(Layout().top(10) == Layout())
        
        // Right
        XCTAssertTrue(Layout().right(10) == Layout().right(10))
        XCTAssertFalse(Layout().right(10) == Layout().right(23))
        XCTAssertFalse(Layout().right(10) == Layout())
        
        // Bottom
        XCTAssertTrue(Layout().bottom(10) == Layout().bottom(10))
        XCTAssertFalse(Layout().bottom(10) == Layout().bottom(23))
        XCTAssertFalse(Layout().bottom(10) == Layout())
        
        // Left
        XCTAssertTrue(Layout().left(10) == Layout().left(10))
        XCTAssertFalse(Layout().left(10) == Layout().left(23))
        XCTAssertFalse(Layout().left(10) == Layout())
        
        // Width
        XCTAssertTrue(Layout().width(10) == Layout().width(10))
        XCTAssertFalse(Layout().width(10) == Layout().width(23))
        XCTAssertFalse(Layout().width(10) == Layout())
        
        // Height
        XCTAssertTrue(Layout().height(10) == Layout().height(10))
        XCTAssertFalse(Layout().height(10) == Layout().height(23))
        XCTAssertFalse(Layout().height(10) == Layout())
        
        // CenterHorizontally
        XCTAssertTrue(Layout().centerHorizontally() == Layout().centerHorizontally())
        XCTAssertFalse(Layout().centerHorizontally() == Layout())
        
        // CenteredVertically
        XCTAssertTrue(Layout().centerVertically() == Layout().centerVertically())
        XCTAssertFalse(Layout().centerVertically() == Layout())
    }
    
    // Layout + autolayout
    
    func testLayoutAutolayoutTop() {
        let v = UIView()
        let spv = UIView()
        spv.addSubview(v)
        layout(v, withLayout: Layout().top(11), inView: spv)
        
        XCTAssertTrue(spv.constraints.count == 1)
        let c = spv.constraints[0]
        XCTAssertEqual(c.constant, 11)
        XCTAssertEqual(c.firstItem as? UIView, v)
        XCTAssertEqual(c.secondItem as? UIView, spv)
        XCTAssertEqual(c.firstAttribute, .top)
        XCTAssertEqual(c.secondAttribute, .top)
        XCTAssertEqual(c.multiplier, 1)
        XCTAssertEqual(c.relation, .equal)
        XCTAssertEqual(c.priority, 1000)
        XCTAssertTrue(c.isActive)
    }
    
    func testLayoutAutolayoutRight() {
        let v = UIView()
        let spv = UIView()
        spv.addSubview(v)
        layout(v, withLayout: Layout().right(13), inView: spv)
        
        XCTAssertTrue(spv.constraints.count == 1)
        let c = spv.constraints[0]
        XCTAssertEqual(c.constant, -13)
        XCTAssertEqual(c.firstItem as? UIView, v)
        XCTAssertEqual(c.secondItem as? UIView, spv)
        XCTAssertEqual(c.firstAttribute, .right)
        XCTAssertEqual(c.secondAttribute, .right)
        XCTAssertEqual(c.multiplier, 1)
        XCTAssertEqual(c.relation, .equal)
        XCTAssertEqual(c.priority, 1000)
        XCTAssertTrue(c.isActive)
    }
    
    func testLayoutAutolayoutBottom() {
        let v = UIView()
        let spv = UIView()
        spv.addSubview(v)
        layout(v, withLayout: Layout().bottom(52), inView: spv)
        
        XCTAssertTrue(spv.constraints.count == 1)
        let c = spv.constraints[0]
        XCTAssertEqual(c.constant, -52)
        XCTAssertEqual(c.firstItem as? UIView, v)
        XCTAssertEqual(c.secondItem as? UIView, spv)
        XCTAssertEqual(c.firstAttribute, .bottom)
        XCTAssertEqual(c.secondAttribute, .bottom)
        XCTAssertEqual(c.multiplier, 1)
        XCTAssertEqual(c.relation, .equal)
        XCTAssertEqual(c.priority, 1000)
        XCTAssertTrue(c.isActive)
    }
    
    func testLayoutAutolayoutLeft() {
        let v = UIView()
        let spv = UIView()
        spv.addSubview(v)
        layout(v, withLayout: Layout().left(178), inView: spv)
        
        XCTAssertTrue(spv.constraints.count == 1)
        let c = spv.constraints[0]
        XCTAssertEqual(c.constant, 178)
        XCTAssertEqual(c.firstItem as? UIView, v)
        XCTAssertEqual(c.secondItem as? UIView, spv)
        XCTAssertEqual(c.firstAttribute, .left)
        XCTAssertEqual(c.secondAttribute, .left)
        XCTAssertEqual(c.multiplier, 1)
        XCTAssertEqual(c.relation, .equal)
        XCTAssertEqual(c.priority, 1000)
        XCTAssertTrue(c.isActive)
    }
    
    func testLayoutAutolayoutWidth() {
        let v = UIView()
        let spv = UIView()
        spv.addSubview(v)
        layout(v, withLayout: Layout().width(27), inView: spv)
        
        XCTAssertTrue(v.constraints.count == 1)
        let c = v.constraints[0]
        XCTAssertEqual(c.constant, 27)
        XCTAssertEqual(c.firstItem as? UIView, v)
        XCTAssertNil(c.secondItem)
        XCTAssertEqual(c.firstAttribute, .width)
        XCTAssertEqual(c.secondAttribute, .notAnAttribute)
        XCTAssertEqual(c.multiplier, 1)
        XCTAssertEqual(c.relation, .equal)
        XCTAssertEqual(c.priority, 1000)
        XCTAssertTrue(c.isActive)
    }
    
    func testLayoutAutolayoutHeight() {
        let v = UIView()
        let spv = UIView()
        spv.addSubview(v)
        layout(v, withLayout: Layout().height(81), inView: spv)
        
        XCTAssertTrue(v.constraints.count == 1)
        let c = v.constraints[0]
        XCTAssertEqual(c.constant, 81)
        XCTAssertEqual(c.firstItem as? UIView, v)
        XCTAssertNil(c.secondItem)
        XCTAssertEqual(c.firstAttribute, .height)
        XCTAssertEqual(c.secondAttribute, .notAnAttribute)
        XCTAssertEqual(c.multiplier, 1)
        XCTAssertEqual(c.relation, .equal)
        XCTAssertEqual(c.priority, 1000)
        XCTAssertTrue(c.isActive)
    }
    
    func testLayoutAutolayoutCenterVertically() {
        let v = UIView()
        let spv = UIView()
        spv.addSubview(v)
        layout(v, withLayout: Layout().centerVertically(), inView: spv)
        
        XCTAssertTrue(spv.constraints.count == 1)
        let c = spv.constraints[0]
        XCTAssertEqual(c.constant, 0)
        XCTAssertEqual(c.firstItem as? UIView, v)
        XCTAssertEqual(c.secondItem as? UIView, spv)
        XCTAssertEqual(c.firstAttribute, .centerY)
        XCTAssertEqual(c.secondAttribute, .centerY)
        XCTAssertEqual(c.multiplier, 1)
        XCTAssertEqual(c.relation, .equal)
        XCTAssertEqual(c.priority, 1000)
        XCTAssertTrue(c.isActive)
    }
    
    func testLayoutAutolayoutCenterHorizontally() {
        let v = UIView()
        let spv = UIView()
        spv.addSubview(v)
        layout(v, withLayout: Layout().centerHorizontally(), inView: spv)
        
        XCTAssertTrue(spv.constraints.count == 1)
        let c = spv.constraints[0]
        XCTAssertEqual(c.constant, 0)
        XCTAssertEqual(c.firstItem as? UIView, v)
        XCTAssertEqual(c.secondItem as? UIView, spv)
        XCTAssertEqual(c.firstAttribute, .centerX)
        XCTAssertEqual(c.secondAttribute, .centerX)
        XCTAssertEqual(c.multiplier, 1)
        XCTAssertEqual(c.relation, .equal)
        XCTAssertEqual(c.priority, 1000)
        XCTAssertTrue(c.isActive)
    }
}
