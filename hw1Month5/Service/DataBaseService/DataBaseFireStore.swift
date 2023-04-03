//
//  DataBaseFireStore.swift
//  hw1Month5
//
//  Created by Mac on 29/3/2023.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

final class DataBaseManager {
    static let shared = DataBaseManager()
    
    private let db = Firestore.firestore()
    private init() { }
    
    public func setTo(collection: String, document: String, withData data: [String: Any]) {
        db.collection(collection)
            .document()
            .setData(data) { err in
                if let err = err {
                    print("erroe writing error \(err)")
                } else {
                    print("Document")
                }
            }
    }
    
    public func readFrom(collection: String, document: String) {
        let docRef = db.collection(collection).document(document)
        
        docRef.getDocument { (document, error ) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("document data: \(dataDescription)")
            } else {
                print("")
            }
        }
        
    }
}
