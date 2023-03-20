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
    var model: [Coctails] = []
    private var viewModel = CoctailViewModel()
    private var viewApi = NetworkService.shared.cocktails
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        fetchCarts()
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
    private func fetchCarts() {
        Task {
            do {
                viewApi = try await viewModel.fetchCarts()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_
        collectionView: UICollectionView,
        numberOfItemsInSection section: Int
        ) -> Int {
        return viewApi.drinks!.count
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
        let model = viewApi.drinks![indexPath.row]
        cell.display(item: model)
        print("dsff")
        print("cell created")
        cell.delegate = self
        return cell
        
    }
}

extension MenuViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_
        collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
         ) -> CGSize {
        return CGSize(
            width: collectionView.frame.width / 2 - 13,
            height: collectionView.frame.height / 2
        )
    }
    func collectionView(_
        collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
         )  {
        guard let cell = collectionView.cellForItem(at: indexPath) as? RiceCollectionViewCell else { return }
        cell.delegate = self
        cell.delegate?.didSelectionsProducts(item: viewApi.drinks![indexPath.row])
    }
}

extension MenuViewController: ProductsCellDelegate {
    func didSelectionsProducts(item: Coctails) {
        let secondVC = DescriptViewController()
        secondVC.prod = item
        navigationController?.pushViewController(secondVC, animated: true)
    }
}
















