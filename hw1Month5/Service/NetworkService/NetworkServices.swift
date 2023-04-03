//
//  NetworkServices.swift
//  hw1Month5
//
//  Created by Mac on 13/3/2023.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    
//    private init() { }
    private var dataTask: URLSessionDataTask?
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
    
    func searchProduct(by word: String) async throws -> CotailsByName {
            var urlComponents  = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "www.thecocktaildb.com"
            urlComponents.path = "/api/json/v1/1/search.php"
            urlComponents.queryItems = [.init(name: "s", value: word)]
            
            guard let url = urlComponents.url else {
                return try CotailsByName(from: [] as! Decoder)
            }
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        
         return try NetworkHelpers.decode(with: data)
        }
}

