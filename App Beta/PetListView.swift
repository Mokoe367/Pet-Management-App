//
//  PetListView.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/16/23.
//

import SwiftUI

struct PetListTopBar: View {
    
    var body: some View {
        NavigationStack {
            
            HStack(spacing: 12) {
                
                Text("Pet List")
                    .font(.title).fontWeight(.heavy)
                    .foregroundStyle(Color(.white))
                Spacer(minLength: 0)
                
                NavigationLink(destination: PetListAdd().navigationBarBackButtonHidden(),
                    label: {
                    VStack {
                        Image(systemName: "plus.app.fill")
                            .foregroundColor(Color("Light Green"))
                            .padding(10)
                            .background(Color.black.opacity(0.1))
                            .clipShape(Circle())
                        Text("Add")
                            .font(.system(size: 10, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color(.white))
                    }
                })
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
                NavigationLink(destination: Text("Delete"),
                    label: {
                    VStack {
                        Image(systemName: "minus.circle")
                            .foregroundColor(Color("Light Green"))
                            .padding(10)
                            .background(Color.black.opacity(0.1))
                            .clipShape(Circle())
                        Text("Delete")
                            .font(.system(size: 10, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color(.white))
                    }
                })
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background(Color("Dark Green"))
        }
    }
}

struct PetListView: View {
    
    @EnvironmentObject private var petListVm: petListViewModel
    @State var selection = ""
    
    var body: some View {
        
        NavigationStack {
            VStack {
                PetListTopBar()
                List {
                    ForEach(petListVm.pets) { item in
                        NavigationLink(
                            destination: PetListDetail(petID: item.petId),
                            label: {
                                HStack {
                                    AsyncImage(url: URL(string: item.photoURL)) { phase in
                                        if let image = phase.image {
                                            image
                                                .resizable()
                                                .frame(width: 64, height: 64)
                                                .scaledToFit()
                                                .clipShape(Circle())
                                        } else {
                                            Image(systemName: "person")
                                                .frame(width: 64, height: 64)
                                                .scaledToFit()
                                                .clipShape(Circle())
                                        }
                                    }
                                    .overlay(RoundedRectangle(cornerRadius: 64)
                                    .stroke(Color.black, lineWidth: 3))
                                    
                                    Spacer()
                                    
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    Spacer()
                                }
                            })
                    }
                }
                .searchable(text: $selection, placement: .automatic)
            }
            .onAppear {
                petListVm.fetchUsersPets()
            }
        }
    }
}

struct PetListAdd: View {
    
    @Environment(\.presentationMode) private var presentationMode : Binding<PresentationMode>
    @EnvironmentObject private var petListVm: petListViewModel
    private let validator = CreateValidator()
    @State private var shouldShowImagePicker = false
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State private var image: UIImage?
    @State private var name: String = ""
    @State private var tag: String = ""
    @State private var breed: String = ""
    @State private var notes: String = ""
    @State private var birthDate = Date.now
    
    var body: some View {
        VStack {
            HStack() {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    VStack {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color("Light Green"))
                            .padding(10)
                            .background(Color.black.opacity(0.1))
                            .clipShape(Circle())
                        Text("Cancel")
                            .font(.system(size: 10, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color(.white))
                    }
                })
                Spacer()
                
                Text("Add Pet To List")
                    .font(.title).fontWeight(.heavy)
                    .foregroundStyle(.white)
                
                Spacer()
                Button(action: { persistImageToStorage() }, label: {
                    VStack {
                        Image(systemName: "plus.app.fill")
                            .foregroundColor(Color("Light Green"))
                            .padding(10)
                            .background(Color.black.opacity(0.1))
                            .clipShape(Circle())
                        Text("Add")
                            .font(.system(size: 10, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color(.white))
                    }
                })
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
                    Text("Birthdate:").frame(maxWidth: .infinity, alignment: .leading)
                }.padding(10)
                VStack {
                    Text("Tag:").frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Tag", text: $tag)
                        .border(Color("Dark Green"))
                        .textFieldStyle(.roundedBorder)
                }.padding(10)
                VStack {
                    Text("Breed:").frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Breed", text: $breed)
                        .border(Color("Dark Green"))
                        .textFieldStyle(.roundedBorder)
                }.padding(10)
                VStack {
                    Text("Select Image:").frame(maxWidth: .infinity, alignment: .leading)
                    Button {
                        shouldShowImagePicker.toggle()
                    } label: {
                        VStack {
                            if let image = self.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 128, height: 128)
                                    .scaledToFit()
                                    .clipShape(Circle())
                            }
                            else {
                                Image(systemName: "photo.artframe")
                                    .resizable()
                                    .frame(width: 64, height: 64)
                                    .padding()
                                    .foregroundStyle(Color(.black))
                            }
                        }
                        .overlay(RoundedRectangle(cornerRadius: 64)
                            .stroke(Color.black, lineWidth: 3))
                    }
                }.padding(10)
                VStack {
                    Text("Notes:").frame(maxWidth: .infinity, alignment: .leading)
                    TextField("Notes", text: $notes, axis: .vertical)
                        .border(Color("Dark Green"))
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(5, reservesSpace: true)
                }.padding(10)
            }
            Spacer()
        }
        .alert(errorMessage, isPresented: $showError, actions: {})
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil, content: {
            ImagePicker(image: $image)
        })
    }
    
    private func storePetInformation(id: String, imageURL: String) {
        guard let uid = AuthenticationManager.shared.auth.currentUser?.uid else {
            return
        }
       
        let birthday = birthDate.formatted(date: .numeric, time: .omitted)
        
        let petData = ["petId": id, "ownerId": uid, "name": self.name, "breed": self.breed, "note": self.notes, "tag": self.tag, "birthday": birthday, "photoURL": imageURL]
        
        let validatePet = Pet(data: petData)
        
        if validate(pet: validatePet) {
           
            UserManager.shared.firestore.collection("pets").document(id).setData(petData) {
                    err in
                    if let err = err {
                        errorMessage = err.localizedDescription
                        showError = true
                        return
                    }
                print("success pet stored")
                
                }
            
            presentationMode.wrappedValue.dismiss()
        } else {
            print("Erereror")
            return
        }
       
    }
    
    private func persistImageToStorage() {
        let petRef = UserManager.shared.firestore.collection("pets").document()
        let id = petRef.documentID
        let ref = UserManager.shared.storage.reference(withPath: id)
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else {
            self.storePetInformation(id: id, imageURL: "")
            return
        }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                self.errorMessage = err.localizedDescription
                showError = true
                return
            }
            
            ref.downloadURL { url, err in
                if let err = err {
                    self.errorMessage = err.localizedDescription
                    showError = true
                    return
                }
                print("Succes image stored")
                self.storePetInformation(id: id, imageURL: url?.absoluteString ?? "")
            }
            
        }
    }
    
    func validate(pet: Pet) -> Bool {
        do {
            try validator.validate(pet)
        } catch {
            errorMessage = error.localizedDescription
            showError = true
            return false
        }
        
        return true
    }
    
    
}

struct PetListView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [
        TabBarItem(iconName: "house", color: Color.black, title: "Pet List"),
        TabBarItem(iconName: "heart", color: Color.black, title: "Daily List"),
        TabBarItem(iconName: "calendar", color: Color.black, title: "Calendar List"),
        TabBarItem(iconName: "calendar", color: Color.black, title: "Social List"),
        TabBarItem(iconName: "calendar", color: Color.black, title: "Profile")
    ]

    static var previews: some View {
        PetListView()
            .environmentObject(petListViewModel())
    }
}
