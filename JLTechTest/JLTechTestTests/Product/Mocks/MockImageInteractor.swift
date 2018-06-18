//
//  MockImageInteractor.swift
//  JLTechTestTests
//
//  Created by Omer Janjua on 18/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import XCTest
@testable import JLTechTest

class MockImageInteractor: ImageInteracting {
    
    var didFetch = false
    var invokedURL: URL?
    var stubbedResult = ImageResult.failure(testError)
    func fetch(from url: URL, completion: @escaping (ImageResult) -> ()) {
        didFetch = true
        invokedURL = url
        completion(stubbedResult)
    }
}
