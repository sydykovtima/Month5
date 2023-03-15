//
//  MenuViewController.swift
//  hw1Month5
//
//  Created by Mac on 15/3/2023.
//

import UIKit

class MenuViewController: UIViewController{

    static let reuisId = String(describing: MenuViewController.self)

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var DishesLabel: UILabel!
    
    private let rice: [Menu] = [
        Menu(name: "Fried Rice",
             riceImage: "4"
            ),
        Menu(name: "Jollof Rice",
             riceImage: "3"
            ),
        Menu(name: "Amala",
                riceImage: "3"
            )
        ,Menu(name: "ButterFly Pasta",
                riceImage: "2"
             )
        ,Menu(name: "Pasta Rigatoni",
                riceImage: "1")
        ,Menu(name: "white Rice",
                riceImage: "6"),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    
    private func configureVC() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(
                                nibName: RiceCollectionViewCell.reusId,
                                bundle: nil),
                        forCellWithReuseIdentifier: RiceCollectionViewCell.reusId
        )
    }
}

extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_
        collectionView: UICollectionView,
        numberOfItemsInSection section: Int
        ) -> Int {
        return rice.count
    }

    func collectionView(_
         collectionView: UICollectionView,
         cellForItemAt indexPath: IndexPath
         ) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier:
        RiceCollectionViewCell.reusId,
        for: indexPath
        ) as! RiceCollectionViewCell
        let model = rice[indexPath.row]
        cell.display(item: model)
        cell.delegate = self
        return cell
        
    }
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_
        collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
         ) -> CGSize {
        return CGSize(width: collectionView.frame.height / 4,
                      height: collectionView.frame.height / 2)
    }
    func collectionView(_
        collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
         )  {
        let vc = DescriptViewController()
        vc.text = rice[indexPath.row].riceImage
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MenuViewController: ProductsCellDelegate {
    func didSelectionsProducts(item: Menu) {
        let secondVC = storyboard?
            .instantiateViewController(withIdentifier: DescriptViewController.id
            ) as! DescriptViewController
        navigationController?.pushViewController(secondVC, animated: true)
    }
}
