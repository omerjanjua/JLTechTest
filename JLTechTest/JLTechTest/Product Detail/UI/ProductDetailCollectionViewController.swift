//
//  ProductDetailCollectionViewController.swift
//  JLTechTest
//
//  Created by Omer Janjua on 18/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import UIKit

protocol ProductDetailViewing: class {
    func showErrorMessage(_ message: String)
    func showProductDetail(_ productDetail: ProductDetail)
    func showImage(_ image: UIImage)
}

class ProductDetailCollectionViewController: UICollectionViewController, ProductDetailViewing {

    var productDetail: ProductDetail?
    var image: UIImage?
    var eventHandler: ProductDetailEventHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler.fetchDetails()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return productDetail != nil ? 3 : 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetail != nil ? 1 : 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            return setUpImageCell(collectionView: collectionView, at: indexPath)
        } else if indexPath.section == 1 {
            return setUpPurchaseInformationCell(collectionView: collectionView, at: indexPath)
        } else {
            return setUpProductDetailCell(collectionView: collectionView, at: indexPath)
        }
    }
    
    // MARK: - ProductDetailView
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func showProductDetail(_ productDetail: ProductDetail) {
        self.productDetail = productDetail
        collectionView?.reloadData()
        title = productDetail.title
    }
    
    func showImage(_ image: UIImage) {
        self.image = image
        let imageCells = collectionView?.visibleCells.compactMap { cell in
            return cell as? ImageCell
        }
        imageCells?.first?.setImage(image)
    }
    
    // MARK: - Custom Cell Setup
    
    private func setUpImageCell(collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        if let image = image {
            cell.setImage(image)
        }
        return cell
    }
    
    private func setUpPurchaseInformationCell(collectionView: UICollectionView, at indexPath: IndexPath) -> PurchaseInformationCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PurchaseInformationCell", for: indexPath) as! PurchaseInformationCell
        cell.setPrice(productDetail!.price)
        cell.setGuarantee(productDetail!.guarantee)
        return cell
    }
    
    private func setUpProductDetailCell(collectionView: UICollectionView, at indexPath: IndexPath) -> DetailsCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
        cell.setText(productDetail!.description)
        return cell
    }
}
