//
//  PetDetails.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/16/23.
//

import SwiftUI

struct PetListDetail: View {
    
    let petID: String
    @ObservedObject private var petDetailsVM = petDetailsViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            PetListDetailTopBarView(petVM: petDetailsVM)
            VStack {
                ScrollView {
                    VStack{
                        Text("Name: ").frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        ZStack {
                            Rectangle()
                                .border(Color("Dark Green"))
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            HStack {
                                Text(petDetailsVM.pet?.name ?? "")
                                    .padding(.horizontal)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .padding(5)
                        }
                    }
                    VStack {
                        Text("Birthday:").frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        ZStack {
                            Rectangle()
                                .border(Color("Dark Green"))
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            HStack {
                                Text(petDetailsVM.pet?.birthday ?? "")
                                    .textFieldStyle(.roundedBorder)
                                    .padding(.horizontal)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .padding(5)
                        }
                    }
                    VStack {
                        Text("Tag:").frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        ZStack {
                            Rectangle()
                                .border(Color("Dark Green"))
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            HStack {
                                Text(petDetailsVM.pet?.tag ?? "")
                                    .textFieldStyle(.roundedBorder)
                                    .padding(.horizontal)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .padding(5)
                        }
                    }
                    VStack {
                        Text("Breed:").frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        ZStack {
                            Rectangle()
                                .border(Color("Dark Green"))
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            HStack {
                                Text(petDetailsVM.pet?.breed ?? "")
                                    .textFieldStyle(.roundedBorder)
                                    .padding(.horizontal)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .padding(5)
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
                                Text(petDetailsVM.pet?.note ?? "")
                                    .lineLimit(5, reservesSpace: true)
                                    .padding(.horizontal)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                            .padding(10)
                        }
                    }
                }
            }.padding(.vertical)
        }.onAppear {
            petDetailsVM.fetchPetData(petID: petID)
        }
    }
}

struct PetListDetailTopBarView: View {
    
    @Environment(\.presentationMode) private var presentationMode : Binding<PresentationMode>

    @StateObject var petVM: petDetailsViewModel
    
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
                        
                        NavigationLink(destination: PetDetailsEdit(petDetailsVM: petVM).navigationBarBackButtonHidden(), label: {
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
                    }
                        
                    .navigationBarBackButtonHidden()
                
                    HStack(spacing: 12) {
                        NavigationLink(destination: PetDetailsMedical() , label: {
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
                        NavigationLink(destination: PetDetailsEvents() , label: {
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
                        NavigationLink(destination: PetDetailsReminders(currentPetId: petVM.pet?.petId ?? "") , label: {
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
                        NavigationLink(destination: PetDetailsComments() , label: {
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

struct PetDetailsEdit: View {
    
    @Environment(\.presentationMode) private var presentationMode : Binding<PresentationMode>
    private let validator = CreateValidator()
    @State var petDetailsVM: petDetailsViewModel
    @State private var pet: Pet?
    @State private var shouldShowImagePicker = false
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State private var image: UIImage?
    @State private var name: String = ""
    @State private var tag: String = ""
    @State private var breed: String = ""
    @State private var notes: String = ""
    @State private var imageURL: String? = ""
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
                
                Text("Edit Pet Info")
                    .font(.title).fontWeight(.heavy)
                    .foregroundStyle(.white)
                
                Spacer()
                Button(action: { updateImageStorage() }, label: {
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
                                AsyncImage(url: URL(string: imageURL ?? "")) { phase in
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
        .onAppear {
            pet = Pet(petId: petDetailsVM.pet?.petId ?? "", ownerId: petDetailsVM.pet?.ownerId ?? "", name: petDetailsVM.pet?.name ?? "", breed: petDetailsVM.pet?.breed ?? "", note: petDetailsVM.pet?.note ?? "", tag: petDetailsVM.pet?.tag ?? "", birthday: petDetailsVM.pet?.birthday ?? "", photoURL: petDetailsVM.pet?.photoURL ?? "")
            name = pet?.name ?? ""
            breed = pet?.breed ?? ""
            notes = pet?.note ?? ""
            tag = pet?.tag ?? ""
            imageURL = pet?.photoURL ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            birthDate = dateFormatter.date(from: pet?.birthday ?? "") ?? Date()
        }
        .alert(errorMessage, isPresented: $showError, actions: {})
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil, content: {
            ImagePicker(image: $image)
        })
    }
    
    private func updatePetInformation(imageURL: String) {
      
        let birthday = self.birthDate.formatted(date: .numeric, time: .omitted)
        
        let petData = ["petId": pet?.petId ?? "", "ownerId": pet?.ownerId ?? "" , "name": self.name, "breed": self.breed, "note": self.notes, "tag": self.tag, "birthday": birthday, "photoURL": imageURL]
        
        let validatePet = Pet(data: petData)
        
        if validate(pet: validatePet) {
           
            UserManager.shared.firestore.collection("pets").document(pet?.petId ?? "").setData(petData, merge: true) {
                    err in
                    if let err = err {
                        errorMessage = err.localizedDescription
                        showError = true
                        return
                    }
                print("success pet updated")
                
                }
        
            presentationMode.wrappedValue.dismiss()
        } else {
            print("Erereror")
            return
        }
       
    }
    
    private func updateImageStorage() {
        let ref = UserManager.shared.storage.reference(withPath: pet?.petId ?? "")
        
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else {
            self.updatePetInformation(imageURL: self.imageURL ?? "")
            return
        }
    
        if(pet?.photoURL == "") {
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
                    self.updatePetInformation(imageURL: url?.absoluteString ?? "")
                }
            }
        } else {
            ref.delete { err in
                if let err = err {
                    self.errorMessage = err.localizedDescription
                    showError = true
                    return
                } else {
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
                            self.updatePetInformation(imageURL: url?.absoluteString ?? "")
                        }
                    }
                }
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



struct PetDetailView_Previews: PreviewProvider {
    
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
