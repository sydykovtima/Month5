//
//  SplashViewController.swift
//  hw1Month5
//
//  Created by Mac on 2/4/2023.
//

import UIKit

class SplashViewController: UIViewController {

        private let keychain = KeyChainManager.shared
        private let encoder = JSONDecoder()
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970

            if let data = keychain.read(with: Constants.Keychain.service, Constants.Keychain.account),
               let date = try? decoder.decode(Date.self, from: data),
               date > Date() {
                let vc = DashboardTabBarController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            } else {
                let vc = storyboard!.instantiateViewController(withIdentifier: "ViewController")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            }
        }
    }
