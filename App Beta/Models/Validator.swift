//
//  Validator.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/28/23.
//

import Foundation

struct CreateValidator {
    
    func validate(_ pet: Pet) throws {
        
        if pet.breed.isEmpty {
            throw CreateValidatorError.invalidBreed
        }
        
        if pet.name.isEmpty {
            throw CreateValidatorError.invalidName
        }
        
        if pet.tag.isEmpty {
            throw CreateValidatorError.invalidTag
        }
    }
}

extension CreateValidator {
    enum CreateValidatorError: LocalizedError {
        case invalidBreed
        case invalidName
        case invalidTag
    }
}

extension CreateValidator.CreateValidatorError {
    
    var errorDescription: String? {
        switch self {
        case .invalidBreed:
            return "Breed can't be empty"
        case .invalidName:
            return "Name can't be empty"
        case .invalidTag:
            return "Tag can't be empty"
        }
    }
}
