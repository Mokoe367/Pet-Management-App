//
//  AuthenticationManager.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/24/23.
//

import Foundation
import FirebaseAuth

class AuthenticationManager: NSObject {
    
    let auth: Auth
    
    static let shared = AuthenticationManager()
    
    override init() {
        self.auth = Auth.auth()
        
        super.init()
    }
    
}
