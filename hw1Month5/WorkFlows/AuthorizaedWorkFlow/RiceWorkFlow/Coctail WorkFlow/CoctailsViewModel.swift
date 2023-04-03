//
//  RiceViewModel.swift
//  hw1Month5
//
//  Created by Mac on 13/3/2023.
//

import Foundation

class CoctailViewModel {
    
    private let networkService = NetworkService.shared
    
    var coctails: [Coctails] = []
    
    func fetchCoctails() async throws -> CotailsByName{
        return try await networkService.fetchCocktails()
    }
}
