//
//  TabBarController.swift
//  hw1Month5
//
//  Created by Mac on 27/3/2023.
//

import UIKit

class DashboardTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = MenuViewController()
        let busket = BusketViewController()
        
         
        menu.title = "home"
        busket.title = "basket"
        
        self.setViewControllers([menu, busket], animated: false)
     
    }

}
