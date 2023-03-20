//
//  ProductModel.swift
//  hw1Month5
//
//  Created by Mac on 13/3/2023.
//

import Foundation
import UIKit

struct Description {
    var image: String
}

extension UIImageView {
    func getImage(from path: String) {
        guard let url = URL(string: path) else { return }
        Task {
            let (data, _) = try await URLSession.shared.data(from: url)
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
    }
}
