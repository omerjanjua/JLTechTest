//
//  MockProductView.swift
//  JLTechTestTests
//
//  Created by Omer Janjua on 18/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import XCTest
@testable import JLTechTest

class MockProductView: ProductViewing {
    
    var invokedErrorMessage: String?
    func showErrorMessage(_ message: String) {
        invokedErrorMessage = message
    }
    
    var invokedProducts: [Product]?
    func showProducts(_ products: [Product]) {
        invokedProducts = products
    }
    
    var invokedImage: UIImage?
    var invokedImageIndex: Int?
    func showImage(image: UIImage, at index: Int) {
        invokedImage = image
        invokedImageIndex = index
    }
}
