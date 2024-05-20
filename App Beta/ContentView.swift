//
//  ContentView.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection: String = "Pet List"
    @State private var tabSelection: TabBarItem = TabBarItem(iconName: "house", color: Color.black, title: "Pet List")  
    @StateObject private var vm = ContentViewModel()
    @StateObject private var petListvm = petListViewModel()
   
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            PetListView()
                .tabBarItem(tab: TabBarItem(iconName: "house", color: Color.black, title: "Pet List"), selection: $tabSelection)
            DailyListView()
                .tabBarItem(tab: TabBarItem(iconName: "calendar.day.timeline.left", color: Color.black, title: "Daily List"), selection: $tabSelection)
            
            CalenderListView()
                .tabBarItem(tab: TabBarItem(iconName: "calendar", color: Color.black, title: "Calendar List"), selection: $tabSelection)
            SocialListView()
                .tabBarItem(tab: TabBarItem(iconName: "person.2.fill", color: Color.black, title: "Social List"), selection: $tabSelection)
            ProfileView()
                .tabBarItem(tab: TabBarItem(iconName: "person.2.fill", color: Color.black, title: "Profile"), selection: $tabSelection)
        }.fullScreenCover(isPresented: $vm.isUserCurrentlyLoggedOut, content: {
            AuthenticationView(didCompleteLoginProcess: {
                self.vm.isUserCurrentlyLoggedOut = false
                self.vm.fetchCurrentUser()
                self.petListvm.fetchUsersPets()
            })
        })
        .environmentObject(vm)
        .environmentObject(petListvm)
    }
}

struct CustomTabBarView: View {
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color("Dark Green").ignoresSafeArea(edges: .bottom))
    }
}

extension CustomTabBarView {
    
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .clipShape(Circle())
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
            
        }
        .foregroundColor(selection == tab ? Color("Light Green") : Color.black)
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .background(selection == tab ? tab.color.opacity(0.2) : Color("Light Green"))
        .cornerRadius(10)
    }
    
    private func switchToTab(tab: TabBarItem) {
        withAnimation(.easeInOut) {
            selection = tab
        }
    }
}

struct TabBarItem: Hashable {
    let iconName: String
    let color: Color
    let title: String
}

struct CustomTabBarView_Previews: PreviewProvider {
    
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
