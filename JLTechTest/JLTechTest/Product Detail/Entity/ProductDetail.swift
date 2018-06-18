//
//  ProductDetail.swift
//  JLTechTest
//
//  Created by Omer Janjua on 18/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import Foundation

struct ProductDetail: Equatable {
    let title: String
    let price: String
    let image: String
    let description: String
    let guarantee: String
}

func ==(lhs: ProductDetail, rhs: ProductDetail) -> Bool {
    return lhs.title == rhs.title
        && lhs.price == rhs.price
        && lhs.image == rhs.image
        && lhs.description == rhs.description
        && lhs.guarantee == rhs.guarantee
}
