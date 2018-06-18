//
//  MockProductInteractor.swift
//  JLTechTestTests
//
//  Created by Omer Janjua on 18/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import XCTest
@testable import JLTechTest

let testError = NSError(domain: "testing", code: 123)

class MockProductInteractor: ProductInteracting {
    
    var didFetch = false
    var stubbedResult = ProductResult.failure(testError)
    func fetch(completion: @escaping (ProductResult) -> ()) {
        didFetch = true
        completion(stubbedResult)
    }
}
