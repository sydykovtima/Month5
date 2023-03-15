//
//  ViewController.swift
//  hw1Month5
//
//  Created by Mac on 13/3/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var dateOfBirth: UITextField!
    @IBOutlet private weak var adress: UITextField!
    @IBAction func register(_ sender: Any) {
        let vc = MenuViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

