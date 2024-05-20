//
//  Reminders.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/30/23.
//

import Foundation

struct Reminder: Codable, Identifiable {
    
    var id: String { reminderId }
    
    let reminderId: String
    let petId: String
    let name: String
    let location: String
    let time: String
    let date: String
    let note: String
    let notification: Bool
    let notificationTime: String
    let repeatDates: [String]

    init(data: [String: Any]) {
        self.reminderId = data["reminderId"] as? String ?? ""
        self.petId = data["petId"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.location = data["location"] as? String ?? ""
        self.time = data["time"] as? String ?? ""
        self.date = data["date"] as? String ?? ""
        self.note = data["note"] as? String ?? ""
        self.notification = data["notification"] as? Bool ?? false
        self.notificationTime = data["notificationTime"] as? String ?? ""
        self.repeatDates = data["repeatDates"] as? [String] ?? []
    }
    
    init(reminderId: String, petId: String, name: String, location: String, time: String, date: String, note: String, notification: Bool, notificationTime: String, repeatDates: [String]) {
        self.reminderId = reminderId
        self.petId = petId
        self.name = name
        self.location = location
        self.time = time
        self.date = date
        self.note = note
        self.notification = notification
        self.notificationTime = notificationTime
        self.repeatDates = repeatDates
    }
}
