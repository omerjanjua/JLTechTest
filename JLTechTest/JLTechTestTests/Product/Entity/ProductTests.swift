//
//  ProductTests.swift
//  JLTechTestTests
//
//  Created by Omer Janjua on 17/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import XCTest
@testable import JLTechTest

class ProductTests: XCTestCase {
    
    func testFalseResults() {
        XCTAssertNotEqual(Product(productId: "123", price: "123", title: "123", image: "path/123"), Product(productId: "345", price: "23", title: "fgsdh", image: "path/erwrew"))
    }
    
    func testCorrectResults() {
        XCTAssertEqual(Product(productId: "123", price: "500", title: "dishwasher", image: "dishwasher/123"), Product(productId: "123", price: "500", title: "dishwasher", image: "dishwasher/123"))
    }
}
