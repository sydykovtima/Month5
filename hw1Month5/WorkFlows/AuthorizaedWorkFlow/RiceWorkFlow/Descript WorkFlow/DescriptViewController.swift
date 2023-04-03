//
//  DescriptViewController.swift
//  hw1Month5
//
//  Created by Mac on 15/3/2023.
//

import UIKit
import CoreData

protocol CounterCellDelegate: AnyObject {
    func increaseTap()
    func decreaseTap()
}

enum CounterType {
    case plus
    case minus
}

class DescriptViewController: UIViewController {
    
    static let id = String(describing: DescriptViewController.self)
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var imageRice: UIImageView!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var circle: UIView!
    @IBOutlet weak var coctailsImages: UIImageView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBAction func busket(_ sender: Any)
    {
        let vc = BusketViewController()
         guard let name = descriptLabel.text else {
             return
         }
         vc.createItems(name: name)
        
    }
    

    weak var delegate: CounterCellDelegate?
    private var image: UIImage?
    var product: Coctails?
    private var counter = Counter(c: 0)
    private let images: [Description] = [
        Description(image: "6"),
        Description(image: "Maslo"),
        Description(image: "gribs"),
        Description(image: "Carrot")
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        print(product?.strDrink)
        guard let product = product else { return }
        configureView(from: product)
    }
    
    override func viewDidLoad() { 
        super.viewDidLoad()
        let tap  = UITapGestureRecognizer(target: self,
                                          action: #selector(didTapOnImage))
        likeImageView.addGestureRecognizer(tap)
        configurCV()
        getCounter()
    }
    
    func dis(item: Counter) {
        counterLabel.text = "\(item.counter)"
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
    
    private func handleCounter(with type: CounterType) {
        switch type {
        case .plus:
            counter.counter += 1
        case .minus:
            counter.counter -= 1
        }
        StorageManager.shared.saveCounter(with: counter.counter)
        collectionView.reloadData()
    }
    
    private func getCounter() {
        counter.counter = StorageManager.shared.getCounter()
    }
    
    public func configureView(from model: Coctails) {
        imageRice.getImage(from: model.strDrinkThumb)
    }
    @objc
    private func didTapOnImage() {
        print("tapped")
        likeImageView.image = UIImage(systemName: "heart.fill")
        print("tapped")
    }
    @IBAction
    private func increaseTapped() {
        delegate?.increaseTap()
    }
    
    @IBAction
    private func decreasedapped() {
        delegate?.decreaseTap()
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
        dis(item: counter)
        delegate = self
        return cell
    }
}

extension DescriptViewController: CounterCellDelegate {
    func increaseTap() {
        print("Increase")
        handleCounter(with: .plus)
    }
    
    func decreaseTap() {
        print("Decrease")
        handleCounter(with: .minus)
    }
}
