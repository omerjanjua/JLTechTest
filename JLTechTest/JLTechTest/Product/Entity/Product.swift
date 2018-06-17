//
//  Product.swift
//  JLTechTest
//
//  Created by Omer Janjua on 17/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import Foundation

struct Product: Equatable {
    let productID: String
    let price: String
    let title: String
    let image: String
}

func ==(lhs: Product, rhs: Product) -> Bool {
    return lhs.productID == rhs.productID
        && lhs.price == rhs.price
        && lhs.title == rhs.title
        && lhs.image == rhs.image
}
