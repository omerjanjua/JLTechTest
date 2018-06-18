//
//  MockRequest.swift
//  JLTechTestTests
//
//  Created by Omer Janjua on 18/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import Foundation
@testable import JLTechTest

class MockRequest: Request {
    
    var didGet = false
    var invokedPath: String?
    var invocationCount = 0
    var stubbedResult = Result<Data, Error>.failure(testError)
    
    func get(from path: String, completion: @escaping Request.Completion) {
        didGet = true
        invocationCount += 1
        invokedPath = path
        completion(stubbedResult)
    }
}
