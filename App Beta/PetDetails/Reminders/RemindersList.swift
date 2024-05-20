//
//  RemindersList.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/25/23.
//

import SwiftUI

struct PetDetailsReminders: View {
    @Environment(\.presentationMode) private var presentationMode : Binding<PresentationMode>
   // let currentPetId: String
    @StateObject private var remindersVM: petReminderViewModel
    
    init(currentPetId: String) {
        _remindersVM = StateObject(wrappedValue: petReminderViewModel(currentPet: currentPetId))
    }
    
    var body: some View {
        VStack {
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
                    
                    Text("Reminders")
                        .font(.title).fontWeight(.heavy)
                        .foregroundStyle(Color(.white))
                    
                    Spacer()
                    
                    NavigationLink(destination: PetDetailsRemindersAdd(remindersVM: remindersVM), label: {
                        VStack {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(Color("Light Green"))
                                .padding(10)
                                .background(Color.black.opacity(0.1))
                                .clipShape(Circle())
                            Text("Add")
                                .font(.system(size: 10, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color(.white))
                        }
                    })
                    
                    .navigationBarBackButtonHidden()
                    
                }
                HStack {
                    Button(action: {
                        
                    }, label: {
                        VStack {
                            Text("All")
                                .foregroundStyle(Color(.white))
                        }
                    })
                    Button(action: {
                        
                    }, label: {
                        VStack {
                            Text("Scheduled")
                                .foregroundStyle(Color(.black))
                        }
                    })
                    Button(action: {
                        
                    }, label: {
                        VStack {
                            Text("Unscheduled")
                                .foregroundStyle(Color(.black))
                        }
                    })
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background(Color("Dark Green"))
            
            ScrollView {
                List {
                    ForEach(self.remindersVM.reminders) { item in
                        NavigationLink(
                            destination: PetDetailsRemindersDetails(),
                            label: {
                                HStack {
                                    Text(item.date)
                                    Text(item.name)
                                }
                            })
                    }
                }
            }
        }.task {
            do {
                try await self.remindersVM.fetchReminders()
            }
            catch {
                remindersVM.errorMessage = error.localizedDescription
                print(remindersVM.errorMessage)
            }
            
        }
    }
}

struct PetDetailsReminderView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [
        TabBarItem(iconName: "house", color: Color.black, title: "Pet List"),
        TabBarItem(iconName: "heart", color: Color.black, title: "Daily List"),
        TabBarItem(iconName: "calendar", color: Color.black, title: "Calendar List"),
        TabBarItem(iconName: "calendar", color: Color.black, title: "Social List"),
        TabBarItem(iconName: "calendar", color: Color.black, title: "Profile")
    ]

    static var previews: some View {
        ContentView()
            .environmentObject(ContentViewModel())
            .environmentObject(petListViewModel())
    }
}
