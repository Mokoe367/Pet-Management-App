//
//  DailyListView.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/18/23.
//

import SwiftUI

struct DailyListView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
            DailyListTopBar()
            List {
                ForEach(0 ..< 5, id: \.self) { item in
                    NavigationLink(
                        destination: DailyListRemindersDetails(),
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
}


struct DailyListTopBar: View {
    
    @State private var birthDate = Date.now
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Daily List")
                    .font(.title).fontWeight(.heavy)
                    .foregroundStyle(Color(.white))
                
                HStack(spacing: 12) {
                    NavigationLink(destination: DailyListReminderAdd().navigationBarBackButtonHidden(),
                                   label: {
                        VStack {
                            Image(systemName: "plus.app.fill")
                                .foregroundColor(Color("Light Green"))
                                .padding(10)
                                .background(Color.black.opacity(0.1))
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            Text("Add")
                                .font(.system(size: 10, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color(.white))
                        }
                    })
                
                    Spacer()
                    
                    DatePicker(selection: $birthDate, in: Date.now..., displayedComponents: .date) {
                        Text("Date:").frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .background(Color("Light Green"))
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    Menu {
                        Button("Pet 1", action: filter)
                        Button("Pet 2", action: filter)
                        Button("Pet 3", action: filter)
                    } label: {
                        VStack {
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                                .foregroundColor(Color("Light Green"))
                                .padding(10)
                                .background(Color.black.opacity(0.1))
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            Text("filter")
                                .font(.system(size: 10, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color(.white))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background(Color("Dark Green"))
            
        }
    }
    func filter() {
        print("lol")
    }
}

struct DailyListReminderAdd: View {
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
                
                Text("Add Reminder")
                    .font(.title).fontWeight(.heavy)
                    .foregroundStyle(Color(.white))
                
                Spacer()
                Button(action: {},
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
                HStack {
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
                    Menu {
                        Button("Pet 1", action: selectPet)
                        Button("Pet 2", action: selectPet)
                        Button("Pet 3", action: selectPet)
                    } label: {
                        VStack {
                            Text("Select")
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundStyle(Color("Dark Green"))
                            
                        }
                    }
                }.padding(10)
                VStack {
                    Text("Name:").frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Name", text: $name)
                        .border(Color("Dark Green"))
                        .textFieldStyle(.roundedBorder)
                }.padding(10)
                DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
                    Text("Date:").frame(maxWidth: .infinity, alignment: .leading)
                }.padding(10)
                VStack {
                    Text("Time:").frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Time", text: $name)
                        .border(Color("Dark Green"))
                        .textFieldStyle(.roundedBorder)
                }.padding(10)
                VStack {
                    Text("Location").frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Location", text: $name)
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
                    Text("Notes").frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Notes", text: $name, axis: .vertical)
                        .border(Color("Dark Green"))
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(5, reservesSpace: true)
                }.padding(10)
            }
            Spacer()
        }
    }
    func selectPet() {
        print("tset")
    }
}


struct DailyListRemindersDetails: View {
    @Environment(\.presentationMode) private var presentationMode : Binding<PresentationMode>
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
                
                Spacer()
                NavigationLink(
                    destination: PetDetailsRemindersEdit(),
                    label: {
                    VStack {
                        Image(systemName: "pencil")
                            .foregroundColor(Color("Light Green"))
                            .padding(10)
                            .background(Color.black.opacity(0.1))
                            .clipShape(Circle())
                        Text("Edit")
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

struct DailyListRemindersEdit: View {
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
                
                Text("Reminder Details Edit")
                    .font(.title).fontWeight(.heavy)
                    .foregroundStyle(Color(.white))
                
                Spacer()
                Button(action: {},
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
                DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
                    Text("Date:").frame(maxWidth: .infinity, alignment: .leading)
                }.padding(10)
                VStack {
                    Text("Time:").frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Time", text: $name)
                        .border(Color("Dark Green"))
                        .textFieldStyle(.roundedBorder)
                }.padding(10)
                VStack {
                    Text("Location").frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Location", text: $name)
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
                    Text("Notes").frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Notes", text: $name, axis: .vertical)
                        .border(Color("Dark Green"))
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(5, reservesSpace: true)
                }.padding(10)
            }
            Spacer()
        }
    }
}


#Preview {
    ContentView()
}
