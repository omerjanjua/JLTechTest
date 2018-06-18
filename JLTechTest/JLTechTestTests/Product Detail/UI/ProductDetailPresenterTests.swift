//
//  ProductDetailPresenterTests.swift
//  JLTechTestTests
//
//  Created by Omer Janjua on 18/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import XCTest
@testable import JLTechTest

class ProductDetailPresenterTests: XCTestCase {
    
    var presenter: ProductDetailPresenter!
    var mockedProductDetailInteractor: MockProductDetailInteractor!
    var mockedImageInteractor: MockImageInteractor!
    var mockedView: MockProductDetailView!
    let id = "product_id"
    let productDetail = ProductDetail(title: "title", price: "£99.99", image: "image", description: "description", guarantee: "guarantee")
    
    override func setUp() {
        super.setUp()
        mockedProductDetailInteractor = MockProductDetailInteractor()
        mockedImageInteractor = MockImageInteractor()
        mockedView = MockProductDetailView()
        presenter = ProductDetailPresenter(productId: id, productDetailInteractor: mockedProductDetailInteractor, imageInteractor: mockedImageInteractor, view: mockedView)
    }
    
    // MARK: - fetchDetails
    
    func test_fetchDetails_shouldFetchProduct_withID() {
        presenter.fetchDetails()
        XCTAssertEqual(mockedProductDetailInteractor.invokedID, id)
    }
    
    func test_fetchDetails_shouldNotifyView_whenFetchFails() {
        mockedProductDetailInteractor.stubbedResult = .failure(testError)
        presenter.fetchDetails()
        XCTAssertEqual(mockedView.invokedErrorMessage, "There was a problem fetching the product details. Please try again later.")
    }
    
    func test_fetchDetails_shouldNotifyView_whenFetchingSucceeds() {
        stubProductDetail()
        presenter.fetchDetails()
        XCTAssertEqual(mockedView.invokedProductDetail, productDetail)
    }
    
    func test_fetchDetails_shouldFetchImage_whenFetchingDetails() {
        stubProductDetail()
        presenter.fetchDetails()
        XCTAssertEqual(mockedImageInteractor.invokedURL, URL(string: productDetail.image)!)
    }
    
    func test_fetchDetails_shouldShowImage_whenImageIsFetched() {
        stubProductDetail()
        presenter.fetchDetails()
        mockedImageInteractor.stubbedResult = .success(testImageData)
        presenter.fetchDetails()
        XCTAssertNotNil(mockedView.invokedImage)
    }
    
    // MARK: - Helpers
    
    func stubProductDetail() {
        mockedProductDetailInteractor.stubbedResult = .success(productDetail)
    }
}

