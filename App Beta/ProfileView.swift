//
//  ProfileView.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/24/23.
//

import SwiftUI

struct ProfileView: View {

    @EnvironmentObject private var vm: ContentViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            HStack(spacing: 0) {
                Button(action: { }, label: {
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
                
                Text("Profile")
                    .font(.title).fontWeight(.heavy)
                    .foregroundStyle(Color(.white))
                
                Spacer()
                
                Button(action: {
                    vm.handleSignOut()
                }, label: {
                    VStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(Color("Light Green"))
                            .padding(10)
                            .background(Color.black.opacity(0.1))
                            .clipShape(Circle())
                        Text("Log Out")
                            .font(.system(size: 10, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color(.white))
                    }
                })
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background(Color("Dark Green"))
            VStack {
                Text("Id:").frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                ZStack {
                    Rectangle()
                        .border(Color("Dark Green"))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    HStack {
                        let id = vm.user?.uid ?? ""
                        Text(id)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(5)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            
            VStack {
                Text("Email:").frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                ZStack {
                    Rectangle()
                        .border(Color("Dark Green"))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                    HStack {
                        let email = vm.user?.email ?? ""
                        Text(email)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(5)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            
            Spacer()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ContentViewModel())
        .environmentObject(petListViewModel())
}
