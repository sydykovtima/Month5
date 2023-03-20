//
//  NetworkServices.swift
//  hw1Month5
//
//  Created by Mac on 13/3/2023.
//

import Foundation
//
// struct NetworkLayer {
//    let baseUrl = URL(string:"www.thecocktaildb.com/api/json/v1/1/search.php")!
//
//    func fetchCocktails() async throws -> CotailsByName {
//        var cocktails =  CotailsByName(drinks: [])
//        for value in  UnicodeScalar("a").value...UnicodeScalar("z").value {
//            guard let uniCodeletter = UnicodeScalar(value),
//            case let letter = String(uniCodeletter) else {
//                fatalError("error")
//            }
//            print("letter: \(letter)")
//            let drinks = try await fetchDataByletter(letter)
////            print("cocktails model for letter: \(letter) is \(drinks)")
//
//            cocktails.drinks?.append(contentsOf: drinks.drinks ?? [])
//
//
//        }
//        return cocktails
//
//    }
//
//    private func fetchDataByletter(_ char: String) async throws -> CotailsByName {
//       var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "thecocktaildb.com"
//        urlComponents.path = "/api/json/v1/1/search.php"
//        urlComponents.queryItems = [.init(name: "f", value: char)]
//        guard let url = urlComponents.url else {
//            fatalError("Url not correct")
//        }
//
//        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
//        return try NetworkHelpers.decode(with: data)
//    }
//}

final class NetworkService {
    
    static let shared = NetworkService()
    
    private init() { }
    
    var cocktails =  CotailsByName(drinks: [])
    func fetchCocktails() async throws -> CotailsByName {
        var cocktails1 = cocktails
        for value in  UnicodeScalar("a").value...UnicodeScalar("z").value {
            guard let uniCodeletter = UnicodeScalar(value),
                  case let letter = String(uniCodeletter) else {
                fatalError("error")
            }
            
            let drinks = try await fetchDataByletter(letter)
            cocktails1.drinks?.append(contentsOf: drinks.drinks ?? [])
        }
        return cocktails1
    }
    private func fetchDataByletter(_ char: String) async throws -> CotailsByName {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "thecocktaildb.com"
        urlComponents.path = "/api/json/v1/1/search.php"
        urlComponents.queryItems = [.init(name: "f", value: char)]
        guard let url = urlComponents.url else {
            fatalError("Url not correct")
        }
        
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        return try NetworkHelpers.decode(with: data)
    }
}
