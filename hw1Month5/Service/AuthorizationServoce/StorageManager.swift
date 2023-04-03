//
//  StorageManager.swift
//  hw1Month5
//
//  Created by Mac on 29/3/2023.
//

import Foundation

final class StorageManager {
    static let shared = StorageManager()
    
    private init() { }
    
    func saveCounter(with number: Int) {
        UserDefaults.standard.set(number, forKey: "counter")
    }
    
    func getCounter() -> Int {
        return UserDefaults.standard.integer(forKey: "counter")
    }
}
