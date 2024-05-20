//
//  CustomTabBarContainerView.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/13/23.
//

import SwiftUI
                    
struct CustomTabBarContainerView<Content:View>: View {
    
    let content: Content
    @Binding var selection: TabBarItem
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                content
            }
            CustomTabBarView(tabs: tabs, selection: $selection)
        }.onPreferenceChange(TabBarItemsPreferenceKey.self, perform: { value in
            self.tabs = value
        })
    }
}

struct CustomTabBarContentView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [
        TabBarItem(iconName: "house", color: Color.black, title: "Pet List"),
        TabBarItem(iconName: "heart", color: Color.black, title: "Daily List"),
        TabBarItem(iconName: "calendar", color: Color.black, title: "Calendar List"),
        TabBarItem(iconName: "calendar", color: Color.black, title: "Social List"),
        TabBarItem(iconName: "calendar", color: Color.black, title: "Profile")
    ]
    
    static var previews: some View {
        CustomTabBarContainerView(selection: .constant(tabs.first!)) {
            Color.red
        }
    }
}
