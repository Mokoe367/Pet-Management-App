//
//  App_BetaApp.swift
//  App Beta
//
//  Created by Joshua Sevilla on 10/12/23.
//

import SwiftUI
import Firebase

@main
struct App_BetaApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
              //  .environmentObject(ContentViewModel())
            //.environmentObject(petListViewModel())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}
