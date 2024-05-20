//
//  viewModels.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/30/23.
//

import Foundation
import SwiftUI

@MainActor
class ContentViewModel: ObservableObject {
    
    @Published var errorMessage = ""
    @Published var user: UserProfile?
    
    init() {
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut = AuthenticationManager.shared.auth.currentUser?.uid == nil
        }
        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        guard let uid = UserManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        self.errorMessage = "\(uid)"
        UserManager.shared.firestore.collection("users").document(uid).getDocument {
            snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user. \(error)"
                return
            }
            
            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                return
            }
            
            self.user = UserProfile(data: data)
            
           // self.errorMessage = user.email
        }
    }
    
    @Published var isUserCurrentlyLoggedOut = false
    
    func handleSignOut() {
        isUserCurrentlyLoggedOut.toggle()
        try? AuthenticationManager.shared.auth.signOut()
        print("signed out")
    }
}

final class petListViewModel: ObservableObject {
    
    @Published var pets = [Pet]()
    @Published var errorMessage = ""
    
    func fetchUsersPets() {
        
        self.pets = []
        
        guard let uid = AuthenticationManager.shared.auth.currentUser?.uid else {
            return
        }
        
        UserManager.shared.firestore.collection("pets").whereField("ownerId", isEqualTo: uid).getDocuments {
            documentsSnapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch pets: \(error)"
                print("Failed to fetch pets: \(error)")
                return
            }
            
            documentsSnapshot?.documents.forEach({ snapshot in
                let data = snapshot.data()
                self.pets.append(.init(data: data))
            })
            
            //self.errorMessage = "Fetched users"
        }
       // print("Success fetched")
    }
}

@MainActor
final class petDetailsViewModel: ObservableObject {
    @Published var errorMessage = ""
    @Published var pet: Pet?
    
    func fetchPetData(petID: String) {
        UserManager.shared.firestore.collection("pets").document(petID).getDocument {
            snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current pet. \(error.localizedDescription)"
                print(self.errorMessage)
                return
            }
            
            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                print(self.errorMessage)
                return
            }
            
            self.pet = Pet(data: data)
           // print(self.pet)
            
        }
    }
}

@MainActor
final class petReminderViewModel: ObservableObject {
    @Published var currentPet: String
    @Published var reminders = [Reminder]()
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    @Published var reminder: Reminder?
    
    init(currentPet: String) {
        self.currentPet = currentPet
    }
    
    func fetchReminders() async throws {
        
        self.reminders = []
        
        let snapshot = try await UserManager.shared.firestore.collection("reminders").getDocuments()
        
        snapshot.documents.forEach { documentSnapshot in
            let documentData = documentSnapshot.data()
            reminders.append(.init(data: documentData))
          }
    }
    
    func addReminder(newReminder: Reminder, presentationMode: Binding<PresentationMode>) {
        let reminderRed = UserManager.shared.firestore.collection("reminders").document()
        let id = reminderRed.documentID
        
        let reminderData = ["reminderId": id, "petId": newReminder.petId, "name": newReminder.name, "location": newReminder.location, "time": newReminder.time, "date": newReminder.date, "note": newReminder.note, "notification": newReminder.notification, "notificationTime": newReminder.notificationTime, "repeatDates": newReminder.repeatDates] as [String : Any]
        
        UserManager.shared.firestore.collection("reminders").document(id).setData(reminderData) {
                err in
                if let err = err {
                    self.errorMessage = err.localizedDescription
                    self.showError = true
                    return
                }
            print("success reminder stored")
            self.showError = false
            presentationMode.wrappedValue.dismiss()
            return
            }
        
    }
    
}

