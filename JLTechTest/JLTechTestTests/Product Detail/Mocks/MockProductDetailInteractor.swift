//
//  MockProductDetailInteractor.swift
//  JLTechTestTests
//
//  Created by Omer Janjua on 18/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import Foundation
@testable import JLTechTest

class MockProductDetailInteractor: ProductDetailInteracting {
    
    var didFetch = false
    var invokedID: String?
    var stubbedResult: ProductDetailResult = .failure(testError)
    func fetch(id: String, _ completion: @escaping (ProductDetailResult) -> ()) {
        didFetch = true
        invokedID = id
        completion(stubbedResult)
    }
}
