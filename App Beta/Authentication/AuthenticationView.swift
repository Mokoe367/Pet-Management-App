//
//  AuthenticationView.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/24/23.
//

import SwiftUI

enum customError: Error, LocalizedError {
    case authenticationError
    case userManagerError
    case urlError(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .authenticationError:
            return "Authentication Error"
        case .userManagerError:
            return "Can't get user"
        case .urlError(error: let error):
            return "Error: \(error)"
        }
    }
}


struct AuthenticationView: View {
    
    @State var didCompleteLoginProcess: () -> ()
    
    @State private var showError: Bool = false
    @State private var errorMessage: String  = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                TextField("Email", text: $email)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background {
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .stroke(Color("Dark Green"), lineWidth: 1)
                    }
                    .autocapitalization(.none) .autocapitalization(.none)
            
                SecureField("password", text: $password)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background {
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .stroke(Color("Dark Green"), lineWidth: 1)
                    }
                    .autocapitalization(.none) .autocapitalization(.none)
                
                Button {
                    Task {
                        loginUser()
                    }
                } label: {
                    Text("Sign in with email")
                        .foregroundStyle(Color(.white))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(Color("Dark Green"))
                        }
                }
                .padding(.top, 10)
                
                Spacer()
                
                HStack {
                    Text("Don't Have an account?")
                        .foregroundStyle(Color(.gray))
                    NavigationLink {
                        SignInEmailView(didCompleteLoginProcess: $didCompleteLoginProcess)
                    } label: {
                        Text("Sign up with email")
                            .fontWeight(.bold)
                            .foregroundStyle(Color("Dark Green"))
                    }
                }.frame(maxWidth: .infinity, alignment: .bottom)
            }
            .navigationTitle("Sign In")
            .padding(10)
            .alert(errorMessage, isPresented: $showError, actions: {})
        }
    }
    private func loginUser() {
        AuthenticationManager.shared.auth.signIn(withEmail: email, password: password) {
            result, err in
            if let err = err {
                errorMessage = err.localizedDescription
                showError = true
                return
            }
            
            print("Successfully logged in as user: \(result?.user.email ?? "")")
            
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
    AuthenticationView(didCompleteLoginProcess: {})
}
