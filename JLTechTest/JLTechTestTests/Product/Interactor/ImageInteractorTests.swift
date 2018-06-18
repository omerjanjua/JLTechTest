//
//  ImageInteractorTests.swift
//  JLTechTestTests
//
//  Created by Omer Janjua on 18/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import XCTest
@testable import JLTechTest

class ImageInteractorTests: XCTestCase {
    
    var interactor: ImageInteractor!
    var mockedRequestFactory: MockRequestFactory!
    var mockedSpecialRequest: SpecialMockRequest!
    var mockedRequest: MockRequest {
        return mockedRequestFactory.stubbedRequest
    }
    let url = URL(string: "http://test.com/some/path")!
    
    override func setUp() {
        super.setUp()
        mockedSpecialRequest = SpecialMockRequest()
        mockedRequestFactory = MockRequestFactory()
        interactor = ImageInteractor(requestFactory: mockedRequestFactory)
    }
    
    // MARK: - fetch
    
    func test_fetch_shouldCreateRequest_fromURL() {
        fetchSynchronously()
        XCTAssertEqual(mockedRequestFactory.invokedURL, url)
        XCTAssert(mockedRequest.didGet)
    }
    
    func test_fetch_shouldNotCreateRequest_whenOneIsAlreadyInProgress() {
        mockedRequestFactory.stubbedRequest = mockedSpecialRequest
        interactor.fetch(from: url) { _ in  }
        interactor.fetch(from: url) { result in
            let error = result.error as? ImageInteractor.Error
            XCTAssertEqual(error, .requestAlreadyInProgress)
        }
        XCTAssertEqual(mockedSpecialRequest.invocationCount, 1)
    }
    
    func test_fetch_shouldBeAbleToRepeatARequest_whenTheOriginalHasFinished() {
        fetchSynchronously()
        fetchSynchronously()
        XCTAssertEqual(mockedRequest.invocationCount, 2)
    }
    
    func test_fetch_shouldPassError_whenRequestFails() {
        mockedRequest.stubbedResult = .failure(testError)
        let error = fetchSynchronously().error as NSError?
        XCTAssertEqual(error, testError)
    }
    
    func test_fetch_shouldPassData_whenRequestSucceeds() {
        let data = "image data".data(using: .utf8)!
        mockedRequest.stubbedResult = .success(data)
        XCTAssertEqual(fetchSynchronously().result, data)
    }
    
    // MARK: - Helpers
    
    @discardableResult
    func fetchSynchronously() -> ImageResult {
        var result: ImageResult!
        interactor.fetch(from: url) { r in
            result = r
        }
        return result
    }
    
    class SpecialMockRequest: MockRequest {
        
        var invokedCompletion: Request.Completion?
        
        override func get(from path: String, completion: @escaping Request.Completion) {
            invokedCompletion = completion
            super.get(from: path) { _ in  }
        }
        
    }
}
