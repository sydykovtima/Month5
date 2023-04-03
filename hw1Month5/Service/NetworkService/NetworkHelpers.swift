//
//  NetworkHelpers.swift
//  hw1Month5
//
//  Created by Mac on 13/3/2023.
//

import Foundation

struct NetworkHelpers {
    
    static func decode<T: Decodable>(with data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}

