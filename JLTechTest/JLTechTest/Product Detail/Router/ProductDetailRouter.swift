//
//  ProductDetailRouter.swift
//  JLTechTest
//
//  Created by Omer Janjua on 17/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import UIKit

protocol ProductDetailRouting {
    func showProductDetails(productId: String)
}

class PushingProductDetailRouter: ProductDetailRouting {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showProductDetails(productId: String) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailCollectionViewController") as! ProductDetailCollectionViewController
        let productDetailInteractor = ProductDetailInteractor(request: JLRequest(baseURL: URL(string: "https://api.johnlewis.com/v1")!))
        let presenter = ProductDetailPresenter(productId: productId, productDetailInteractor: productDetailInteractor, imageInteractor: ImageInteractor(), view: viewController)
        viewController.eventHandler = presenter
        navigationController?.pushViewController(viewController, animated: true)
    }
}
