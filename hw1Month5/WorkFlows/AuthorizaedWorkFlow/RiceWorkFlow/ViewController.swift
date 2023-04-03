//
//  ViewController.swift
//  hw1Month5
//
//  Created by Mac on 13/3/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class ViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var dateOfBirth: UITextField!
    @IBOutlet private weak var adress: UITextField!
    
    private var auth = AuthorizationManager()
      private let encoder = JSONDecoder()
    private let keychain = KeyChainManager.shared
    
    @IBAction func register(_ sender: Any) {
        guard let phone = emailTextField.text, !phone.isEmpty else {
            return
        }
        auth.tryToSendSMSCode(phoneNumber: phone) { result in
            switch result {
            case .success:
                let vc = VerifyViewController()
                let navVC = UINavigationController(rootViewController: vc)
                navVC.modalPresentationStyle = .fullScreen
                self.present(navVC, animated: true)
            case .failure(let error):
                break
            }
        }
        }
    }

