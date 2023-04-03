//
//  VerifyViewController.swift
//  hw1Month5
//
//  Created by Mac on 24/3/2023.
//

import UIKit
import TransitionButton
class VerifyViewController: UIViewController {
    
    static let id = String(describing: VerifyViewController.self)
    private var auth = AuthorizationManager()
    @IBOutlet weak var verifyTexField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    
    let button = TransitionButton(frame: CGRect(x: 170, y: 426, width: 100, height: 35))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.center = view.center
        button.backgroundColor = .systemYellow
        button.setTitle("Confirm", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        button.spinnerColor = .white
        view.addSubview(button)
        
    }
    
    @objc func didTapButton() {
        guard let vCode = verifyTexField.text, !vCode.isEmpty else {
            return
        }
        auth.tryToSignIn(smsCode: vCode) { result in
            if case .success = result {
                self.button.startAnimation()
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.button.stopAnimation(animationStyle: .expand, revertAfterDelay: 1) {
                        let vc = MenuViewController()
                        let navVC = UINavigationController(rootViewController: vc)
//                        navVC.modalPresentationStyle = .fullScreen
                        self.present(navVC, animated: true)
                    }
                }
                    
            } else {
                self.verifyTexField.layer.borderColor = UIColor.red.cgColor
                self.verifyTexField.placeholder = "error"
                self.verifyTexField.layer.borderWidth = 3
                self.label.text = "wrong code"
                
            }
        }
    }
}
            
      
