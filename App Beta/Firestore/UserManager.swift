//
//  UserManager.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/25/23.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

struct DBUser {
    let userId: String
    let email: String?
    let dateCreated: Date?
}

class UserManager: NSObject {
    
    static let shared = UserManager()
    let auth: Auth
    let firestore: Firestore
    let storage: Storage
    
    override init() {
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        self.storage = Storage.storage()
        
        super.init()
    }
    
    
   func getUser(userId: String) async throws -> DBUser {
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        
        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
            throw customError.userManagerError
        }
       
       let email = data["email"] as? String
       let dateCreated = data["date_created"] as? Date
       
       return DBUser(userId: userId, email: email, dateCreated: dateCreated)
    }
}
