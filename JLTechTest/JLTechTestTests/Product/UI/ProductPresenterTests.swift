//
//  ProductPresenterTests.swift
//  JLTechTestTests
//
//  Created by Omer Janjua on 18/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import XCTest
@testable import JLTechTest

let testImageData = Data(base64Encoded: "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8DwHwAFBQIAX8jx0gAAAABJRU5ErkJggg==")!

class ProductPresenterTests: XCTestCase {
    
    var presenter: ProductPresenter!
    var mockedProductInteractor: MockProductInteractor!
    var mockedView: MockProductView!
    var mockedImageInteractor: MockImageInteractor!
    var mockedRouter: MockProductDetailRouter!
    
    override func setUp() {
        super.setUp()
        mockedProductInteractor = MockProductInteractor()
        mockedImageInteractor = MockImageInteractor()
        mockedView = MockProductView()
        mockedRouter = MockProductDetailRouter()
        presenter = ProductPresenter(productInteractor: mockedProductInteractor, imageInteractor: mockedImageInteractor, view: mockedView, router: mockedRouter)
    }
    
    // MARK: - fetchProducts
    
    func test_fetchProducts_shouldFetchProducts() {
        presenter.fetchProducts()
        XCTAssert(mockedProductInteractor.didFetch)
    }
    
    func test_fetchProducts_shouldShowError_whenFetchingFails() {
        mockedProductInteractor.stubbedResult = .failure(testError)
        presenter.fetchProducts()
        XCTAssertEqual(mockedView.invokedErrorMessage, "There was a problem fetching the products. Please try again later.")
    }
    
    func test_fetchProducts_shouldShowProducts_whenFetchingSucceeds() {
        stubValidProducts()
        presenter.fetchProducts()
        XCTAssertEqual(mockedView.invokedProducts!, validProducts)
    }
    
    // MARK: - fetchImage(at:)
    
    func test_fetchImage_shouldNotFetchImage_whenOutOfBounds() {
        stubValidProducts()
        presenter.fetchProducts()
        presenter.fetchImage(at: 1)
        XCTAssertFalse(mockedImageInteractor.didFetch)
        presenter.fetchImage(at: -1)
        XCTAssertFalse(mockedImageInteractor.didFetch)
    }
    
    func test_fetchImage_shouldFetchImage() {
        stubValidProducts()
        presenter.fetchProducts()
        presenter.fetchImage(at: 0)
        XCTAssert(mockedImageInteractor.didFetch)
        XCTAssertEqual(mockedImageInteractor.invokedURL?.absoluteString, validProducts[0].image)
    }
    
    func test_fetchImage_shouldShowImageInView_whenImageIsFetched() {
        stubValidProducts()
        presenter.fetchProducts()
        mockedImageInteractor.stubbedResult = .success(testImageData)
        presenter.fetchImage(at: 0)
        XCTAssertNotNil(mockedView.invokedImage)
        XCTAssertEqual(mockedView.invokedImageIndex, 0)
    }
    
    // MARK: - showDetails
    
    func test_showDetails_shouldCallRouter() {
        stubValidProducts()
        presenter.fetchProducts()
        presenter.showDetails(at: 0)
        XCTAssertEqual(mockedRouter.invokedID, validProducts[0].productId)
    }
    
    func test_showDetails_shouldNotCallRouter_whenIndexIsOutOfBounds() {
        stubValidProducts()
        presenter.fetchProducts()
        presenter.showDetails(at: 1)
        XCTAssertFalse(mockedRouter.didShowProductDetails)
        presenter.showDetails(at: -1)
        XCTAssertFalse(mockedRouter.didShowProductDetails)
    }
    
    // MARK: - Helpers
    
    var validProducts: [Product] {
        return [
            Product(productId: "id1", price: "price1", title: "title1", image: "imagePath1")
        ]
    }
    
    func stubValidProducts() {
        mockedProductInteractor.stubbedResult = .success(validProducts)
    }
}
