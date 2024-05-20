//
//  SignInEmailView.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/24/23.
//

import SwiftUI

struct SignInEmailView: View {
    
    @Binding var didCompleteLoginProcess: () -> ()
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background {
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(Color("Dark Green"), lineWidth: 1)
                }
                .autocapitalization(.none) .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background {
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .stroke(Color("Dark Green"), lineWidth: 1)
                }
                .autocapitalization(.none) .autocapitalization(.none)
            
            Button(action: {
                Task {
                    signUp()
                }
            }, label: {
                Text("Sign up with email")
                    .foregroundStyle(Color(.white))
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .fill(Color("Dark Green"))
                    }
            })
            
            Spacer()
        }
        .padding(10)
        .navigationTitle("Sign up with Email")
        .alert(errorMessage, isPresented: $showError, actions: {})
    }
    
    func signUp() {
        AuthenticationManager.shared.auth.createUser(withEmail: email, password: password) {
            result, err in
            if let err = err {
                print("Failed to create user:, err")
                errorMessage = err.localizedDescription
                showError = true
                return
            }
            
            print("Successfully created user: \(result?.user.uid ?? "")")
            
            self.storeUserInformation()
        }
    }
    
    private func storeUserInformation() {
        guard let uid = AuthenticationManager.shared.auth.currentUser?.uid else {
            return
        }
        
        let userData = ["email": self.email, "uid": uid]
        UserManager.shared.firestore.collection("users").document(uid).setData(userData) {
                err in
                if let err = err {
                    errorMessage = err.localizedDescription
                    showError = true
                    return
                }
            print("success")
            
            self.didCompleteLoginProcess()
            }
    }
    
    func setError(_ error: Error) async {
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

#Preview {
    NavigationStack {
        SignInEmailView(didCompleteLoginProcess: .constant {})
    }
}
