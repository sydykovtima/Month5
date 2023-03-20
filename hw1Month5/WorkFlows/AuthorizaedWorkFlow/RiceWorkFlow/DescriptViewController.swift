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
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var circle: UIView!
    
    private var image: UIImage?
    
    var producta = ""
    var prod: Coctails?
    
    private let images: [Description] = [
        Description(image: "6"),
        Description(image: "Maslo"),
        Description(image: "gribs"),
        Description(image: "Carrot")
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        print(prod?.strDrink)
        guard let prod = prod else { return }
        configureView(from: prod)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptLabel.lineBreakMode = .byCharWrapping
        descriptLabel.text = "Our Fried Rice Is Made From The Finest Ingredients And Veggies. Ebery Single Dish Is Made With Fresh VegeTables. Each Plate Is Served With Our Signature Chicken and A Free"
        descriptLabel.adjustsFontSizeToFitWidth = true
        descriptLabel.sizeToFit()
        circle.layer.borderColor = UIColor.red.cgColor
        circle.layer.borderWidth = 2
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
    
    public func configureView(from model: Coctails) {
        imageRice.getImage(from: model.strDrinkThumb)
    }
}

extension DescriptViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_
                        collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 100, height: 80)
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
            .dequeueReusableCell(
                withReuseIdentifier:
                    DescriptionCollectionViewCell.id,
                for: indexPath
            ) as! DescriptionCollectionViewCell
        let model = images[indexPath.row]
        cell.display(item: model)
        return cell
    }
}
