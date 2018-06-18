//
//  ProductCollectionViewCell.swift
//  JLTechTest
//
//  Created by Omer Janjua on 17/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    func setProduct(_ product: Product) {
        titleLabel.text = product.title
        priceLabel.text = product.price
    }
    
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
}
