//
//  ProductDetailPresenter.swift
//  JLTechTest
//
//  Created by Omer Janjua on 18/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import UIKit

protocol ProductDetailEventHandler {
    func fetchDetails()
}

class ProductDetailPresenter: ProductDetailEventHandler {
    
    private let productId: String
    private let productDetailInteractor: ProductDetailInteracting
    private let imageInteractor: ImageInteracting
    private weak var view: ProductDetailViewing?
    
    init(productId: String, productDetailInteractor: ProductDetailInteracting, imageInteractor: ImageInteracting, view: ProductDetailViewing) {
        self.productId = productId
        self.productDetailInteractor = productDetailInteractor
        self.imageInteractor = imageInteractor
        self.view = view
    }
    
    func fetchDetails() {
        productDetailInteractor.fetch(id: productId) { [weak self] result in
            self?.handleFetchedDetails(result)
        }
    }
    
    private func handleFetchedDetails(_ result: Result<ProductDetail, Error>) {
        switch result {
        case .failure:
            view?.showErrorMessage("There was a problem fetching the product details. Please try again later.")
        case .success(let detail):
            view?.showProductDetail(detail)
            fetchImage(from: detail.image)
        }
    }
    
    private func fetchImage(from path: String) {
        guard let url = URL(string: path) else { return }
        imageInteractor.fetch(from: url) { [weak self] result in
            self?.handleFetchedImage(result)
        }
    }
    
    private func handleFetchedImage(_ result: ImageResult) {
        if let data = result.result,
            let image = UIImage(data: data) {
            view?.showImage(image)
        }
    }
}
