//
//  UserProfile.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/27/23.
//

import Foundation

struct UserProfile: Identifiable {
    
    var id: String { uid }
    
    let uid, email: String
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
    }
}
