//
//  Constants.swift
//  hw1Month5
//
//  Created by Mac on 13/3/2023.
//

import Foundation
import UIKit

enum Constant {
   static let baseUrl = URL(string:"www.thecocktaildb.com/api/json/v1/1/search.php")!
    static let url = URL(string: "www.thecocktaildb.com/api/json/v1/1/search.php?")
}
  
enum Constants {
    enum Keychain {
        static let service = "PhoneAuth"
        static let account = "phoneSigin"
    }
}
