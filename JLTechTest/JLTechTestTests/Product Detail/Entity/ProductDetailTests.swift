//
//  ProductDetailTests.swift
//  JLTechTestTests
//
//  Created by Omer Janjua on 18/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import XCTest
@testable import JLTechTest

class ProductDetailTests: XCTestCase {
    
    func testFalseResults() {
        XCTAssertNotEqual(ProductDetail(title: "were", price: "500", image: "path/wer", description: "foo bar", guarantee: "5 years"), ProductDetail(title: "werf", price: "375", image: "path/path", description: "qwerty", guarantee: "no guarantee"))
    }
    
    func testCorrectResults() {
        XCTAssertEqual(ProductDetail(title: "were", price: "500", image: "path/wer", description: "foo bar", guarantee: "5 years"), ProductDetail(title: "were", price: "500", image: "path/wer", description: "foo bar", guarantee: "5 years"))
    }
}
