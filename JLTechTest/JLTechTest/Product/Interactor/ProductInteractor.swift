//
//  ProductInteractor.swift
//  JLTechTest
//
//  Created by Omer Janjua on 17/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import SwiftyJSON
typealias ProductResult = Result<[Product], Error>

protocol ProductInteracting {
    func fetch(completion: @escaping (ProductResult) -> ())
}

class ProductInteractor: Interactor<[Product]>, ProductInteracting {
    
    init(request: Request) {
        super.init(request: request, parser: Parser())
    }
    
    func fetch(completion: @escaping (ProductResult) -> ()) {
        fetch(path: "/products/search?q=dishwasher&pageSize=20", completion: completion)
    }
    
    class Parser: DataParser<[Product]> {
        
        override func parse(_ data: Data) -> ParsedResult {
            guard let products = try? JSON(data: data)["products"].array else {
                return .failure(DataParserError.couldNotParseResponse)
            }
            return .success(products!.compactMap(toProduct))
        }
        
        private func toProduct(json: JSON) -> Product? {
            guard let productId = json["productId"].string,
                let title = json["title"].string,
                let price = json["price"]["now"].string,
                let image = json["image"].string else {
                    return nil
            }
            
            var updatedImageURL = image
            if image.hasPrefix("//") {
                updatedImageURL = "https:" + image
            }
            return Product(productId: productId, price: "£" + price, title: title, image: updatedImageURL)
        }
    }
}
