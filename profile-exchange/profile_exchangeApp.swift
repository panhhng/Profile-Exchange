//
//  profile_exchangeApp.swift
//  profile-exchange
//
//  Created by Nhân Nguyễn on 6/26/24.
//

import SwiftUI
import FirebaseCore

@main
struct profile_exchangeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
