//
//  ProductPresenter.swift
//  JLTechTest
//
//  Created by Omer Janjua on 17/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import UIKit

class ProductPresenter: ProductEventHandler {
    
    private let productInteractor: ProductInteracting
    private let imageInteractor: ImageInteracting
    private weak var view: ProductViewing?
    private var products: [Product]?
    private let router: ProductDetailRouting
    
    init(productInteractor: ProductInteracting, imageInteractor: ImageInteracting, view: ProductViewing, router: ProductDetailRouting) {
        self.productInteractor = productInteractor
        self.imageInteractor = imageInteractor
        self.view = view
        self.router = router
    }
    
    func fetchProducts() {
        productInteractor.fetch { [weak self] (result) in
            self?.handleFetchedProducts(result)
        }
    }
    
    func fetchImage(at index: Int) {
        guard let products = products,
            let imageURL = imageURL(at: index, in: products) else { return }
        imageInteractor.fetch(from: imageURL) { [weak self] result in
            self?.handleFetchedImage(result, at: index)
        }
    }
    
    func showDetails(at index: Int) {
        guard let products = products, isIndexValid(index, in: products) else { return }
        router.showProductDetails(productId: products[index].productId)
    }
    
    private func handleFetchedProducts(_ result: ProductResult) {
        switch result {
        case .failure:
            view?.showErrorMessage("There was a problem fetching the products. Please try again later.")
        case .success(let products):
            self.products = products
            view?.showProducts(products)
        }
    }
    
    private func handleFetchedImage(_ result: ImageResult, at index: Int) {
        if let imageData = result.result,
            let image = UIImage(data: imageData) {
            view?.showImage(image: image, at: index)
        }
    }
    
    private func imageURL(at index: Int, in products: [Product]) -> URL? {
        guard isIndexValid(index, in: products) else { return nil }
        return URL(string: products[index].image)
    }
    
    private func isIndexValid(_ index: Int, in products: [Product]) -> Bool {
        return 0 <= index && index < products.count
    }
}
