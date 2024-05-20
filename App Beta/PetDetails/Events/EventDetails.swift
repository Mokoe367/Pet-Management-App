//
//  EventDetails.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/25/23.
//

import SwiftUI

struct PetDetailsEventDetails: View {
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
                
                Spacer()
                NavigationLink(
                    destination: PetDetailsEventDetailsEdit(),
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

