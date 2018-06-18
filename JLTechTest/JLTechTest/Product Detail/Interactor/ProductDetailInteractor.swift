//
//  ProductDetailInteractor.swift
//  JLTechTest
//
//  Created by Omer Janjua on 18/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ProductDetailResult = Result<ProductDetail, Error>

protocol ProductDetailInteracting {
    func fetch(id: String, _ completion: @escaping (ProductDetailResult) -> ())
}

class ProductDetailInteractor: Fetcher<ProductDetail>, ProductDetailInteracting {
    
    init(request: Request) {
        super.init(request: request, parser: Parser())
    }
    
    func fetch(id: String, _ completion: @escaping (ProductDetailResult) -> ()) {
        fetch(path: "/products/\(id)", completion: completion)
    }
    
    class Parser: DataParser<ProductDetail> {
        
        override func parse(_ data: Data) -> ParsedResult {
            guard let json = try? JSON(data: data) else {
                return .failure(DataParserError.couldNotParseResponse)
            }
            guard let title = json["title"].string,
                let price = json["price"]["now"].string,
                let image = json["media"]["images"]["urls"].first?.1.string,
                let description = json["details"]["productInformation"].string,
                let guarantee = json["additionalServices"]["includedServices"].first?.1.string else {
                    return .failure(DataParserError.couldNotParseResponse)
            }

            var updatedImageURL = image
            if image.hasPrefix("//") {
                updatedImageURL = "https:" + image
            }
            return .success(ProductDetail(title: title, price: "£" + price, image: updatedImageURL, description: description, guarantee: guarantee))
        }
    }
}
