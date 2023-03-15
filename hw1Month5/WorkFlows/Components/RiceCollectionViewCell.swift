//
//  RiceCollectionViewCell.swift
//  hw1Month5
//
//  Created by Mac on 15/3/2023.
//

import UIKit

protocol ProductsCellDelegate: AnyObject {
    func didSelectionsProducts (item: Menu)
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
    private var rices: Menu?
    func display(item: Menu) {
        rices = item
        menuImage.image = UIImage(named: item.riceImage)
        menuLabel.text = item.name
    }
    
    @objc
    private func didTapOnImage() {
        print("tapped")
        
        guard let rices = rices else {
            return
        }
        delegate?.didSelectionsProducts(item: rices)
    }
}
