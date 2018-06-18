//
//  MockRequestFactory.swift
//  JLTechTestTests
//
//  Created by Omer Janjua on 18/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import XCTest
@testable import JLTechTest

class MockRequestFactory: RequestFactory {
    
    var stubbedRequest = MockRequest()
    var invokedURL: URL?
    func create(fromURL url: URL) -> Request {
        invokedURL = url
        return stubbedRequest
    }
}
