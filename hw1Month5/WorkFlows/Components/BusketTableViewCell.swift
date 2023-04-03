//
//  LikedTableViewCell.swift
//  hw1Month5
//
//  Created by Mac on 28/3/2023.
//

import UIKit

class BusketTableViewCell: UITableViewCell {
    
    static let id = String(describing: BusketTableViewCell.self)
    
    @IBOutlet private weak var imagecocktail: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptLable: UILabel!
    @IBOutlet private weak var ratingLAbel: UILabel!
  
    private var networkService = NetworkService()
    
    func display(item: Note) {
        nameLabel.text = item.strDrink
    }
}
