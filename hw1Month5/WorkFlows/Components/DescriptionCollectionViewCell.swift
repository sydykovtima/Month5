//
//  DescriptionCollectionViewCell.swift
//  hw1Month5
//
//  Created by Mac on 15/3/2023.
//

import UIKit

class DescriptionCollectionViewCell: UICollectionViewCell {
    
    static let id = String(describing: DescriptionCollectionViewCell.self)
    
    @IBOutlet private weak var image: UIImageView!
    
    var product: Coctails?
    func display(item: Description) {
        image.image = UIImage(named: item.image)
    }
    
}
