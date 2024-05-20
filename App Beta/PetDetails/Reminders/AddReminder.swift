//
//  AddReminderView.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/25/23.
//

import SwiftUI

struct PetDetailsRemindersAdd: View {
    @Environment(\.presentationMode) private var presentationMode : Binding<PresentationMode>
    @State var remindersVM: petReminderViewModel
    @State private var name: String = ""
    @State private var date: Date = Date.now
    @State private var location: String  = ""
    @State private var note: String  = ""
    @State private var notification: Bool = false
    @State private var notificationTime: String = ""
    @State private var repeatDates: [String] = ["Monday", "Tuesday"]
    
    var body: some View {
        VStack {
            HStack() {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    VStack {
                        Image(systemName: "arrowshape.backward.circle.fill")
                            .foregroundColor(Color("Light Green"))
                            .padding(10)
                            .background(Color.black.opacity(0.1))
                            .clipShape(Circle())
                        Text("Back")
                            .font(.system(size: 10, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color(.white))
                    }
                })
                Spacer()
                
                Text("Add Reminder")
                    .font(.title).fontWeight(.heavy)
                    .foregroundStyle(Color(.white))
                
                Spacer()
                Button(action: { addReminder() },
                    label: {
                    VStack {
                        Image(systemName: "square.and.arrow.down.fill")
                            .foregroundColor(Color("Light Green"))
                            .padding(10)
                            .background(Color.black.opacity(0.1))
                            .clipShape(Circle())
                        Text("Save")
                            .font(.system(size: 10, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color(.white))
                    }
                })
                .navigationBarBackButtonHidden()
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background(Color("Dark Green"))
            ScrollView {
                VStack {
                    Text("Name:").frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Name", text: $name)
                        .border(Color("Dark Green"))
                        .textFieldStyle(.roundedBorder)
                }.padding(10)
                DatePicker(selection: $date, in: ...Date.now, displayedComponents: .date) {
                    Text("Date:").frame(maxWidth: .infinity, alignment: .leading)
                }.padding(10)
                VStack {
                    Text("Location").frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Location", text: $location)
                        .border(Color("Dark Green"))
                        .textFieldStyle(.roundedBorder)
                }.padding(10)
                VStack {
                    Text("Notification").frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Notification", text: $name)
                        .border(Color("Dark Green"))
                        .textFieldStyle(.roundedBorder)
                }.padding(10)
                VStack {
                    Text("Repeat").frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Repeat", text: $name)
                        .border(Color("Dark Green"))
                        .textFieldStyle(.roundedBorder)
                }.padding(10)
                VStack {
                    Text(remindersVM.currentPet).frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Notes", text: $name, axis: .vertical)
                        .border(Color("Dark Green"))
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(5, reservesSpace: true)
                }.padding(10)
            }
            Spacer()
        }
    }
    @MainActor func addReminder() {
        let newReminder = Reminder(reminderId: "", petId: remindersVM.currentPet, name: name, location: location, time: "", date: "", note: note, notification: notification, notificationTime: "", repeatDates: repeatDates)
        
        remindersVM.addReminder(newReminder: newReminder, presentationMode: presentationMode)
    }
}



