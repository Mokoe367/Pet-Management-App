//
//  SocialListView.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/24/23.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
    @Published var users = [UserProfile]()
    @Published var errorMessage = ""
    
    init() {
        fetchAllUsers()
    }
    
    private func fetchAllUsers() {
        UserManager.shared.firestore.collection("users").getDocuments {
            documentsSnapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch users: \(error)"
                print("Failed to fetch users: \(error)")
                return
            }
            
            documentsSnapshot?.documents.forEach({ snapshot in
                let data = snapshot.data()
                let user = UserProfile(data: data)
                if user.uid != UserManager.shared.auth.currentUser?.uid {
                    self.users.append(.init(data: data))
                }
            })
            
            //self.errorMessage = "Fetched users"
        }
    }
}


struct SocialListView: View {
    
    @State var selection = ""
    @ObservedObject var vm = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                SocialListTopBar()
                Text(vm.errorMessage)
                List {
                    ForEach(vm.users) { user in
                        NavigationLink(
                            destination: socialPetDetails(),
                            label: {
                                HStack {
                                    Image(systemName: "square.and.arrow.down.fill").resizable().frame(width: 50, height: 50)
                                    Text(user.email)
                                }
                            })
                    }
                }.searchable(text: $selection, placement: .automatic)
            }
        }
    }
}

struct socialFilterSheet: View {
    var body: some View {
        VStack {
            Text("XD")
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}

struct SocialListTopBar: View {
    
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            
            HStack(spacing: 12) {
                
                Text("Social List")
                    .font(.title).fontWeight(.heavy)
                    .foregroundStyle(Color(.white))
                Spacer(minLength: 0)
                
                NavigationLink(destination: Text("Share"),
                    label: {
                    VStack {
                        Image(systemName: "plus.app.fill")
                            .foregroundColor(Color("Light Green"))
                            .padding(10)
                            .background(Color.black.opacity(0.1))
                            .clipShape(Circle())
                        Text("Share")
                            .font(.system(size: 10, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color(.white))
                    }
                })
                Button(action: {
                    showingSheet = true
                },
                    label: {
                    VStack {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .foregroundColor(Color("Light Green"))
                            .padding(10)
                            .background(Color.black.opacity(0.1))
                            .clipShape(Circle())
                        Text("Filter")
                            .font(.system(size: 10, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color(.white))
                    }
                })
            }
            .sheet(isPresented: $showingSheet) {
                socialFilterSheet()
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background(Color("Dark Green"))
        }
    }
}

struct SocialListDetailTopBarView: View {
    
    @Environment(\.presentationMode) private var presentationMode : Binding<PresentationMode>

    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HStack(spacing: 0) {
                        
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
                        
                        Text("Pet Details")
                            .font(.title).fontWeight(.heavy)
                            .foregroundStyle(Color(.white))
                        
                        Spacer()
                        
                    }
                        
                    .navigationBarBackButtonHidden()
                
                    HStack(spacing: 12) {
                        NavigationLink(destination: SocialPetDetailsMedical() , label: {
                            VStack {
                                Image(systemName: "cross.case.fill")
                                    .foregroundColor(Color("Light Green"))
                                    .padding(10)
                                    .background(Color.black.opacity(0.1))
                                    .clipShape(Circle())
                                Text("Medical")
                                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                                    .foregroundStyle(Color(.white))
                            }
                        })
                        NavigationLink(destination: SocialPetDetailsEvents() , label: {
                            VStack {
                                Image(systemName: "calendar.day.timeline.left")
                                    .foregroundColor(Color("Light Green"))
                                    .padding(10)
                                    .background(Color.black.opacity(0.1))
                                    .clipShape(Circle())
                                Text("Events")
                                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                                    .foregroundStyle(Color(.white))
                            }
                            
                        })
                        NavigationLink(destination: SocialPetDetailsReminders() , label: {
                            VStack {
                                Image(systemName: "bell.fill")
                                    .foregroundColor(Color("Light Green"))
                                    .padding(10)
                                    .background(Color.black.opacity(0.1))
                                    .clipShape(Circle())
                                Text("Reminders")
                                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                                    .foregroundStyle(Color(.white))
                            }
                        })
                        NavigationLink(destination: SocialPetDetailsComments() , label: {
                            VStack {
                                Image(systemName: "bubble.left.and.text.bubble.right.fill")
                                    .foregroundColor(Color("Light Green"))
                                    .padding(10)
                                    .background(Color.black.opacity(0.1))
                                    .clipShape(Circle())
                                Text("Comments")
                                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                                    .foregroundStyle(Color(.white))
                            }
                        })
                        
                    }
                }
                .padding(.horizontal)
                .padding(.vertical)
                .background(Color("Dark Green"))
            }
        }
    }
}


struct socialPetDetails: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            SocialListDetailTopBarView()
            VStack {
                ZStack {
                    Rectangle()
                        .border(Color("Dark Green"))
                        .foregroundColor(.white)
                        .padding(10)
                  
                    VStack {
                        Text("Name: ")
                            .foregroundStyle(Color("Dark Green"))
                            .padding(10)
                        Text("Name: ")
                            .foregroundStyle(Color("Dark Green"))
                            .padding(10)
                        Text("Name: ")
                            .foregroundStyle(Color("Dark Green"))
                            .padding(10)
                        Text("Name: ")
                            .foregroundStyle(Color("Dark Green"))
                            .padding(10)
                        Text("Name: ")
                            .foregroundStyle(Color("Dark Green"))
                            .padding(10)
                            
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(10)
                }
            }
            ZStack {
                Rectangle()
                    .border(Color("Dark Green"))
                    .foregroundColor(.white)
                    .padding(10)
                ScrollView {
                    Text("Name: ")
                        .foregroundStyle(Color("Dark Green"))
                        .padding(10)
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(10)
            }
        }
    }
}

struct SocialPetDetailsMedical: View {
    @Environment(\.presentationMode) private var presentationMode : Binding<PresentationMode>
    
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
                
                Text("Medical")
                    .font(.title).fontWeight(.heavy)
                    .foregroundStyle(Color(.white))
                
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
                }).hidden()
                
                Spacer()
                    
                .navigationBarBackButtonHidden()
                
               // .navigationTitle(Text("Pet Details").font(.title).fontWeight(.heavy))
                //.navigationBarTitleDisplayMode(.inline)
                
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background(Color("Dark Green"))
            
            List {
                ForEach(0 ..< 5, id: \.self) { item in
                    NavigationLink(
                        destination: Text("Medical Picture"),
                        label: {
                            HStack {
                                Image(systemName: "square.and.arrow.down.fill").resizable().frame(width: 50, height: 50)
                                Text("Pet 1")
                            }
                        })
                }
            }
        }
    }
}

struct SocialPetDetailsEvents: View {
    
    @Environment(\.presentationMode) private var presentationMode : Binding<PresentationMode>
    
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
                
                Text("Events")
                    .font(.title).fontWeight(.heavy)
                    .foregroundStyle(Color(.white))
                
                Spacer()
                
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
                }).hidden()
                    
                .navigationBarBackButtonHidden()
                
               // .navigationTitle(Text("Pet Details").font(.title).fontWeight(.heavy))
                //.navigationBarTitleDisplayMode(.inline)
                
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background(Color("Dark Green"))
            
            List {
                ForEach(0 ..< 5, id: \.self) { item in
                    NavigationLink(
                        destination: SocialPetDetailsEventDetails(),
                        label: {
                            HStack {
                                Image(systemName: "square.and.arrow.down.fill").resizable().frame(width: 50, height: 50)
                                Text("Pet 1")
                            }
                        })
                }
            }
        }
    }
}

struct SocialPetDetailsReminders: View {
    @Environment(\.presentationMode) private var presentationMode : Binding<PresentationMode>
    
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
                    }).hidden()
                        
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
            
            List {
                ForEach(0 ..< 5, id: \.self) { item in
                    NavigationLink(
                        destination: SocialPetDetailsRemindersDetails(),
                        label: {
                            HStack {
                                Image(systemName: "square.and.arrow.down.fill").resizable().frame(width: 50, height: 50)
                                Text("Pet 1")
                            }
                        })
                }
            }
        }
    }
}

struct SocialPetDetailsComments: View {
    @Environment(\.presentationMode) private var presentationMode : Binding<PresentationMode>
    
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
                
                Text("Comments")
                    .font(.title).fontWeight(.heavy)
                    .foregroundStyle(Color(.white))
                
                Spacer()
                    
                .navigationBarBackButtonHidden()
                
               // .navigationTitle(Text("Pet Details").font(.title).fontWeight(.heavy))
                //.navigationBarTitleDisplayMode(.inline)
                
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background(Color("Dark Green"))
            
            List {
                ForEach(0 ..< 5, id: \.self) { item in
                    NavigationLink(
                        destination: PetDetailsEventDetails(),
                        label: {
                            HStack {
                                Image(systemName: "square.and.arrow.down.fill").resizable().frame(width: 50, height: 50)
                                Text("Pet 1")
                            }
                        })
                }
            }
        }
    }
}

struct SocialPetDetailsEventDetails: View {
    @Environment(\.presentationMode) private var presentationMode : Binding<PresentationMode>
    @State private var name: String = ""
    @State private var birthDate = Date.now
    
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
                
                Text("Event Details")
                    .font(.title).fontWeight(.heavy)
                    .foregroundStyle(Color(.white))
                
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
                }).hidden()
                
                Spacer()
                .navigationBarBackButtonHidden()
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background(Color("Dark Green"))
            ScrollView {
                VStack {
                    Text("Selected Pet:").frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ZStack {
                        Rectangle()
                            .border(Color("Dark Green"))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        HStack {
                            Text("Pet 1")
                                .textFieldStyle(.roundedBorder)
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(5)
                    }
                }.padding(5)
                VStack {
                    Text("Name:").frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ZStack {
                        Rectangle()
                            .border(Color("Dark Green"))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        HStack {
                            Text("Pet 1")
                                .textFieldStyle(.roundedBorder)
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(5)
                    }
                }.padding(5)
                VStack {
                    Text("Date:").frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ZStack {
                        Rectangle()
                            .border(Color("Dark Green"))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        HStack {
                            Text("Date")
                                .textFieldStyle(.roundedBorder)
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(5)
                    }
                }.padding(5)
                VStack {
                    Text("Time:").frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ZStack {
                        Rectangle()
                            .border(Color("Dark Green"))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        HStack {
                            Text("5 pm")
                                .textFieldStyle(.roundedBorder)
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(5)
                    }
                }.padding(5)
                VStack {
                    Text("Location:").frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ZStack {
                        Rectangle()
                            .border(Color("Dark Green"))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        HStack {
                            Text("Place")
                                .textFieldStyle(.roundedBorder)
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(5)
                    }
                }.padding(5)
                VStack {
                    Text("Notification:").frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ZStack {
                        Rectangle()
                            .border(Color("Dark Green"))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        HStack {
                            Text("30 min before")
                                .textFieldStyle(.roundedBorder)
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(5)
                    }
                }.padding(5)
                VStack {
                    Text("Category").frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ZStack {
                        Rectangle()
                            .border(Color("Dark Green"))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        HStack {
                            Text("Pet 1")
                                .textFieldStyle(.roundedBorder)
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(5)
                    }
                }.padding(5)
                VStack {
                    Text("Notes:").frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ZStack {
                        Rectangle()
                            .border(Color("Dark Green"))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        VStack {
                            Text("Bob is a nice emu")
                                .lineLimit(5, reservesSpace: true)
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(10)
                    }
                }
            }
            Spacer()
        }
    }
}

struct SocialPetDetailsRemindersDetails: View {
    @Environment(\.presentationMode) private var presentationMode : Binding<PresentationMode>
    @State private var name: String = ""
    @State private var birthDate = Date.now
    
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
                
                Text("Reminder Details")
                    .font(.title).fontWeight(.heavy)
                    .foregroundStyle(Color(.white))
                
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
                }).hidden()
                
                Spacer()
                .navigationBarBackButtonHidden()
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background(Color("Dark Green"))
            ScrollView {
                VStack{
                    Text("Selected Pet:").frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ZStack {
                        Rectangle()
                            .border(Color("Dark Green"))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        HStack {
                            Text("Pet 1")
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(5)
                    }
                }
                VStack{
                    Text("Name:").frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ZStack {
                        Rectangle()
                            .border(Color("Dark Green"))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        HStack {
                            Text("Exercising")
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(5)
                    }
                }
                VStack {
                    Text("Date:").frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ZStack {
                        Rectangle()
                            .border(Color("Dark Green"))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        HStack {
                            Text("05/04/2002")
                                .textFieldStyle(.roundedBorder)
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(5)
                    }
                }
                VStack {
                    Text("Time:").frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ZStack {
                        Rectangle()
                            .border(Color("Dark Green"))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        HStack {
                            Text("8AM")
                                .textFieldStyle(.roundedBorder)
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(5)
                    }
                }
                VStack {
                    Text("Location:").frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ZStack {
                        Rectangle()
                            .border(Color("Dark Green"))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        HStack {
                            Text("Park")
                                .textFieldStyle(.roundedBorder)
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(5)
                    }
                }
                VStack {
                    Text("Notification:").frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ZStack {
                        Rectangle()
                            .border(Color("Dark Green"))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        HStack {
                            Text("30 mins before")
                                .textFieldStyle(.roundedBorder)
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(5)
                    }
                }
                VStack {
                    Text("Repeat:").frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ZStack {
                        Rectangle()
                            .border(Color("Dark Green"))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        HStack {
                            Text("Monday, Wednesday, Friday")
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(10)
                    }
                }
                VStack {
                    Text("Notes:").frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    ZStack {
                        Rectangle()
                            .border(Color("Dark Green"))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        VStack {
                            Text("Bob is a nice emu")
                                .lineLimit(5, reservesSpace: true)
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(10)
                    }
                }
            }
            Spacer()
        }
    }
}



#Preview {
    SocialListView()
}
