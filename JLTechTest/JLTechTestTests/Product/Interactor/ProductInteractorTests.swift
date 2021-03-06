//
//  ProductInteractorTests.swift
//  JLTechTestTests
//
//  Created by Omer Janjua on 18/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import XCTest
@testable import JLTechTest

class ProductInteractorTests: XCTestCase {
    
    var interactor: ProductInteractor!
    var mockedRequest: MockRequest!
    
    override func setUp() {
        super.setUp()
        mockedRequest = MockRequest()
        interactor = ProductInteractor(request: mockedRequest)
    }
    
    // MARK: - fetch
    
    func test_fetch_shouldMakeNetworkRequest() {
        fetchSynchronously()
        XCTAssertEqual(mockedRequest.invokedPath, "/products/search?q=dishwasher&pageSize=20")
    }
    
    func test_fetch_shouldPassError_whenNetworkError() {
        mockedRequest.stubbedResult = .failure(testError)
        let error = fetchSynchronously().error as NSError?
        XCTAssertEqual(error, testError)
    }
    
    // MARK: - Helpers
    
    @discardableResult
    func fetchSynchronously() -> ProductResult {
        var result: ProductResult!
        interactor.fetch { r in
            result = r
        }
        return result
    }
}

class NetworkProductListInteractor_ParserTests: XCTestCase {
    
    var parser: ProductInteractor.Parser!
    
    override func setUp() {
        super.setUp()
        parser = ProductInteractor.Parser()
    }
    
    // MARK: - parse
    
    func test_parse_shouldPassError_whenUnableToParseObject() {
        let error = parser.parse(invalidObjectData).error as? DataParserError
        XCTAssertEqual(error, .couldNotParseResponse)
    }
    
    func test_parse_shouldParseProducts_whenValidObjectIsReturned() {
        XCTAssertEqual(parser.parse(validObjectData).result!, products)
    }
    
    func test_parse_shouldReturnEmptyArray_whenNoProductsAreReturned() {
        XCTAssert(parser.parse(validEmptyObjectData).result!.isEmpty)
    }
    
    func test_parse_shouldIgnoreInvalidObjects() {
        XCTAssertEqual(parser.parse(partiallyValidObjectData).result!, products)
    }
    
    // MARK: - Helpers
    
    var invalidObjectData: Data {
        return "not a valid response".data(using: .utf8)!
    }
    
    var validEmptyObjectData: Data {
        let dictionary = [
            "products": []
        ]
        return try! JSONSerialization.data(withJSONObject: dictionary)
    }
    
    var validObjectData: Data {
        let dictionary = [
            "products": [
                [
                    "productId": "1",
                    "title": "Fully Integrated Dishwasher",
                    "price": [
                        "now": "449.00"
                    ],
                    "image": "http://johnlewis.scene7.com/is/image/JohnLewis/234326372?"
                ],
                [
                    "productId": "2",
                    "title": "Freestanding Dishwasher",
                    "price": [
                        "now": "379.00"
                    ],
                    "image": "http://johnlewis.scene7.com/is/image/JohnLewis/234326391?"
                ]
            ]
        ]
        return try! JSONSerialization.data(withJSONObject: dictionary)
    }
    
    var partiallyValidObjectData: Data {
        let dictionary = [
            "products": [
                // valid
                [
                    "productId": "1",
                    "title": "Fully Integrated Dishwasher",
                    "price": [
                        "now": "449.00"
                    ],
                    "image": "http://johnlewis.scene7.com/is/image/JohnLewis/234326372?"
                ],
                // missing id
                [
                    "title": "Title",
                    "price": [
                        "now": "1"
                    ],
                    "image": "http://image"
                ],
                // missing title
                [
                    "productId": "1",
                    "price": [
                        "now": "1"
                    ],
                    "image": "http://image"
                ],
                // missing price
                [
                    "productId": "1",
                    "title": "Title",
                    "image": "http://image"
                ],
                // missing image
                [
                    "productId": "1",
                    "title": "Title",
                    "price": [
                        "now": "1"
                    ]
                ],
                // valid
                [
                    "productId": "2",
                    "title": "Freestanding Dishwasher",
                    "price": [
                        "now": "379.00"
                    ],
                    "image": "http://johnlewis.scene7.com/is/image/JohnLewis/234326391?"
                ]
            ]
        ]
        return try! JSONSerialization.data(withJSONObject: dictionary)
    }
    
    var products: [Product] {
        return [
            Product(productId: "1", price: "£449.00", title: "Fully Integrated Dishwasher", image: "http://johnlewis.scene7.com/is/image/JohnLewis/234326372?"),
            Product(productId: "2", price: "£379.00", title: "Freestanding Dishwasher", image: "http://johnlewis.scene7.com/is/image/JohnLewis/234326391?")
        ]
    }
}
