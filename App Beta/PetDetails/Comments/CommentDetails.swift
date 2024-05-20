//
//  CommentDetails.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/25/23.
//

import SwiftUI

struct PetDetailsComments: View {
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

