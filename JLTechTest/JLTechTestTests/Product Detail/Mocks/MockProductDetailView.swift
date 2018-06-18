//
//  MockProductDetailView.swift
//  JLTechTestTests
//
//  Created by Omer Janjua on 18/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import UIKit
@testable import JLTechTest

class MockProductDetailView: ProductDetailViewing {
    
    var invokedErrorMessage: String?
    func showErrorMessage(_ message: String) {
        invokedErrorMessage = message
    }
    
    var invokedProductDetail: ProductDetail?
    func showProductDetail(_ productDetail: ProductDetail) {
        invokedProductDetail = productDetail
    }
    
    var invokedImage: UIImage?
    func showImage(_ image: UIImage) {
        invokedImage = image
    }
}
