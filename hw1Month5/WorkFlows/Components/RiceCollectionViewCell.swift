//
//  RiceCollectionViewCell.swift
//  hw1Month5
//
//  Created by Mac on 15/3/2023.
//

import UIKit
import CoreData

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
    @IBOutlet private weak var viewBackGround: UIView!
    @IBAction func buy(_ sender: Any) {
       let vc = BusketViewController()
        guard let name = menuLabel.text else {
            return
        }
        vc.createItems(name: name)
    }
    
    weak var delegate: ProductsCellDelegate?
    private var products: Coctails?
    private var productss:[Coctails] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func display(item: Coctails) {
        products = item
        menuImage.getImage(from: item.strDrinkThumb)
        menuLabel.text = item.strDrink
        menuImage.layer.borderWidth = 2
        menuImage.layer.borderColor = UIColor.black.cgColor
        viewBackGround.layer.borderColor = UIColor.black.cgColor
        viewBackGround.layer.borderWidth = 3
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
