//
//  DescriptViewController.swift
//  hw1Month5
//
//  Created by Mac on 15/3/2023.
//

import UIKit

class DescriptViewController: UIViewController {
    
    static let id = String(describing: DescriptViewController.self)

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var imageRice: UIImageView!
    @IBOutlet weak var descriptLabel: UILabel!
    
    var text = ""
    
    
    
    private let images: [Description] = [
        Description(image: "6"),
        Description(image: "Maslo"),
        Description(image: "gribs"),
        Description(image: "Carrot")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptLabel.lineBreakMode = .byCharWrapping
        descriptLabel.text = "Our Fried Rice Is Made From The Finest Ingredients And Veggies. Ebery Single Dish Is Made With Fresh VegeTables. Each Plate Is Served With Our Signature Chicken and A Free"
        descriptLabel.adjustsFontSizeToFitWidth = true
        descriptLabel.sizeToFit()
        imageRice.image = UIImage(named: text)
        configurCV()
    }

    private func configurCV() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(
                                nibName:
                                DescriptionCollectionViewCell.id,
                                bundle: nil),
        forCellWithReuseIdentifier: DescriptionCollectionViewCell.id)
    }
}

extension DescriptViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_
          collectionView: UICollectionView,
          layout collectionViewLayout: UICollectionViewLayout,
          sizeForItemAt indexPath: IndexPath
          ) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

extension DescriptViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
         ) -> Int {
        return images.count
    }
    
    func collectionView(_
        collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        let cell = collectionView
        .dequeueReusableCell(withReuseIdentifier:
        DescriptionCollectionViewCell.id,
                             for: indexPath
        ) as! DescriptionCollectionViewCell
        let model = images[indexPath.row]
        cell.display(item: model)
        return cell
    }
}
