//
//  Pet.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/27/23.
//

import Foundation

struct Pet: Identifiable {
    
    var id: String { petId }
    
    let petId: String
    let ownerId: String
    let name: String
    let breed: String
    let note: String
    let tag: String
    let birthday: String
    let photoURL: String
    
    init(data: [String: Any]) {
        self.petId = data["petId"] as? String ?? ""
        self.ownerId = data["ownerId"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.breed = data["breed"] as? String ?? ""
        self.note = data["note"] as? String ?? ""
        self.tag = data["tag"] as? String ?? ""
        self.birthday = data["birthday"] as? String ?? ""
        self.photoURL = data["photoURL"] as? String ?? ""
    }
    init(petId: String, ownerId: String, name: String, breed: String, note: String, tag: String, birthday: String, photoURL: String) {
        self.petId = petId
        self.ownerId = ownerId
        self.name = name
        self.breed = breed
        self.note = note
        self.tag = tag
        self.birthday = birthday
        self.photoURL = photoURL
    }
   /* init(viewModel: petDetailsViewModel) {
        self.petId = viewModel.pet?.petId ?? ""
        self.ownerId = viewModel.pet?.ownerId ?? ""
        self.name = viewModel.pet?.name ?? ""
        self.breed =  viewModel.pet?.breed ?? ""
        self.note = viewModel.pet?.note ?? ""
        self.tag = viewModel.pet?.tag ?? ""
        self.birthday = viewModel.pet?.birthday ?? ""
        self.photoURL = viewModel.pet?.photoURL ?? ""
    }*/
    
}
