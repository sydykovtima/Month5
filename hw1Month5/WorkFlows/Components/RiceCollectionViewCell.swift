//
//  RiceCollectionViewCell.swift
//  hw1Month5
//
//  Created by Mac on 15/3/2023.
//

import UIKit

protocol ProductsCellDelegate: AnyObject {
    func didSelectionsProducts (item: Coctails)
}

class RiceCollectionViewCell: UICollectionViewCell {

    static let reusId = String(describing: RiceCollectionViewCell.self)
    
    @IBOutlet private weak var menuImage: UIImageView! {
        didSet {
            menuImage.isUserInteractionEnabled = true
            let tap = UIGestureRecognizer(target: self,
                                          action: #selector(didTapOnImage))
            menuImage.addGestureRecognizer(tap)
        }
    }
    @IBOutlet private weak var menuLabel: UILabel!
    @IBAction func buy(_ sender: Any) {
    }
    
    weak var delegate: ProductsCellDelegate?
    private var products: Coctails?
    func display(item: Coctails) {
        products = item
        menuImage.getImage(from: item.strDrinkThumb)
        menuLabel.text = item.strDrink
        
    }
    
    @objc
    private func didTapOnImage() {
        print("tapped")
        
        guard let products = products else {
            return
        }
        delegate?.didSelectionsProducts(item: products)
    }
}
