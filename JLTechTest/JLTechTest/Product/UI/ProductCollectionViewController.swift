//
//  ProductCollectionViewController.swift
//  JLTechTest
//
//  Created by Omer Janjua on 17/06/2018.
//  Copyright © 2018 Omer Janjua. All rights reserved.
//

import UIKit

protocol ProductViewing: class {
    func showErrorMessage(_ message: String)
    func showProducts(_ products: [Product])
    func showImage(image: UIImage, at index: Int)
}

protocol ProductEventHandler {
    func fetchProducts()
    func fetchImage(at index: Int)
    func showDetails(at index: Int)
}

class ProductCollectionViewController: UICollectionViewController, ProductViewing {
    
    var eventHandler: ProductEventHandler!
    private var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler.fetchProducts()
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCell
        cell.setProduct(products[indexPath.row])
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        eventHandler.fetchImage(at: indexPath.item)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        eventHandler.showDetails(at: indexPath.item)
    }
    
    //MARK: ProductView
    
    func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: "John Lewis", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] _ in
            self?.eventHandler.fetchProducts()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func showProducts(_ products: [Product]) {
        self.products = products
        collectionView?.reloadData()
    }
    
    func showImage(image: UIImage, at index: Int) {
        cellForItem(at: index)?.setImage(image)
    }
    
    private func cellForItem(at index: Int) -> ProductCell? {
        return collectionView?.cellForItem(at: IndexPath(item: index, section: 0)) as? ProductCell
    }
}
