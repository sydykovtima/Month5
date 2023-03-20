//
//  CoctailModal.swift
//  hw1Month5
//
//  Created by Mac on 13/3/2023.
//

import Foundation

struct CotailsByName: Codable {
    var drinks: [Coctails]?
}

struct Coctails: Codable {
   var idDrink: String
   var strDrink: String
    var strDrinkThumb: String
}
