//
//  DetailsCell.swift
//  JLTechTest
//
//  Created by Omer Janjua on 18/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import UIKit

class DetailsCell: UICollectionViewCell {
    
    @IBOutlet private var detailsLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        detailsLabel.text = nil
    }
    
    func setText(_ text: String) {
        detailsLabel.text = text
    }
}
