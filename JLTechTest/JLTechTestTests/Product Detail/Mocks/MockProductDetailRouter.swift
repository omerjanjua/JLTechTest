//
//  MockProductDetailRouter.swift
//  JLTechTestTests
//
//  Created by Omer Janjua on 18/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import XCTest
@testable import JLTechTest

class MockProductDetailRouter: ProductDetailRouting {
    
    var didShowProductDetails = false
    var invokedID: String?
    func showProductDetails(productId: String) {
        didShowProductDetails = true
        invokedID = productId
    }
}
