//
//  EventAdd.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/25/23.
//

import SwiftUI

struct PetDetailsEventDetailsAdd: View {
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
                
                Text("Add Event")
                    .font(.title).fontWeight(.heavy)
                    .foregroundStyle(Color(.white))
                
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
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
                    TextField("Tag", text: $name)
                        .border(Color("Dark Green"))
                        .textFieldStyle(.roundedBorder)
                }.padding(10)
                VStack {
                    Text("Location").frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Breed", text: $name)
                        .border(Color("Dark Green"))
                        .textFieldStyle(.roundedBorder)
                }.padding(10)
                VStack {
                    Text("Notification").frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Name", text: $name)
                        .border(Color("Dark Green"))
                        .textFieldStyle(.roundedBorder)
                }.padding(10)
                VStack {
                    Text("Category").frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Category", text: $name)
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
