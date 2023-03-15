//
//  File.swift
//  hw4Month4
//
//  Created by Mac on 9/2/2023.
//

import Foundation


final class NetworkLayer {
    static let shared = NetworkLayer()
    
    private init() { }
    
    private var baseURL = URL(string: "https://dummyjson.com/products")!
    
    func fetchCategory() throws -> [Category] {
        let decode = JSONDecoder()
        let category = try decode.decode([Category].self, from: Data(categoryJSON.utf8))
        return category
    }
    
    func fetchOrderType() throws -> [TypeOfOrder] {
        let decod = JSONDecoder()
        let orderType = try decod.decode([TypeOfOrder].self, from: Data(orderTypeJSON.utf8))
        return orderType
    }
    
    func fetchProducts() async throws -> Products {
        let request = URLRequest(url: baseURL)
        let (data,_) = try await URLSession.shared.data(for: request)
        return try decode(with: data)
    }
    
    func searchProducts(by word: String) async throws -> Products  {
        let url = baseURL.appendingPathComponent("search")
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [.init(name: "q", value: word)]
        guard let url = urlComponents?.url else {
            return Products(products: [])
        }
        
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        return try decode(with: data)
    }
    
    func decode<T: Decodable>(with data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
        
    func encodeData<T: Encodable>(product: T, completion: @escaping (Result<Data, Error>) -> Void) {
        let encoder = JSONEncoder()
        do {
            let encodedData = try encoder.encode(product)
            completion(.success(encodedData))
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteProductsData(id: Int) async throws -> Bool {
        var request = URLRequest(url: baseURL.appendingPathComponent("\(id)"))
        request.httpMethod = "DELETE"
        let (_, response) = try await URLSession.shared.data(for: request)
        if let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 {
            return true
        } else {
            return false
        }
    }
    
    func postProductsData(model: Product) async throws -> Bool {
        var encodedProductModel: Data?
        encodedProductModel = initializeData(product: encodedProductModel)
        guard encodedProductModel != nil else {
            return false
        }
        
        var request = URLRequest(url: baseURL.appendingPathComponent("add"))
        request.httpMethod = "POST"
        request.httpBody = encodedProductModel
        let (_, response) = try await URLSession.shared.data(for: request)
        if
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 {
            return true
        } else {
            return false
            
        }
    }
    
    private func initializeData<T: Encodable>(product: T) -> Data? {
        var encodedData: Data?
        encodeData(product: product) { result in
            switch result {
            case .success(let model):
                encodedData = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return encodedData
    }
}
