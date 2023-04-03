//
//  MenuViewController.swift
//  hw1Month5
//
//  Created by Mac on 15/3/2023.
//

import UIKit
import FirebaseAuth

class MenuViewController: UIViewController{

    static let reuisId = String(describing: MenuViewController.self)

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var searchCoctails: UISearchBar!
    
    private var viewModel = CoctailViewModel()
    private var coctails: [Coctails] = []
    private var viewApi = NetworkService.shared.cocktails
    private var isloading = false
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        fetchCotails()
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
    
    private func fetchCotails() {
        isloading = true
        Task {
            do {
                viewApi = try await viewModel.fetchCoctails()
                isloading = false
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    private func searchCotails(by word: String) {
        isloading = true
        Task {
            do {
                let model = try await NetworkService.shared.searchProduct(by: word)
                isloading = false
                coctails = model.drinks!
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
              showError(with: error)
            }
        }
    }
    private func showError(with message: Error) {
        let alert = UIAlertController(title: "Error",
        message: message.localizedDescription,
        preferredStyle: .alert)
        alert.addAction(.init(title: "Okay", style: .cancel))
        present(alert, animated: true)
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
        guard let cell = collectionView.cellForItem(at: indexPath) as?
                RiceCollectionViewCell else { return }
        cell.delegate = self
        cell.delegate?.didSelectionsProducts(item:
                                                viewApi.drinks![indexPath.row])
    }
}

extension MenuViewController: ProductsCellDelegate {
    func didSelectionsProducts(item: Coctails) {
        let secondVC = DescriptViewController()
        secondVC.product = item
        navigationController?.pushViewController(secondVC, animated: true)
//        secondVC.modalPresentationStyle = .fullScreen
    }
}

extension MenuViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !isloading {
            searchCotails(by: searchText)
        }
    }
}
















