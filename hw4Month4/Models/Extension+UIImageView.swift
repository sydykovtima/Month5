//
//  Extension+UIImageView.swift
//  hw4Month4
//
//  Created by ibaikaa on 21/2/23.
//

import UIKit

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
