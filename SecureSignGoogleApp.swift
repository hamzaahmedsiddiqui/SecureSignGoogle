//
//  SecureSignGoogleApp.swift
//  SecureSignGoogle
//
//  Created by hamza Ahmed on 2025-10-13.
//

import SwiftUI
import Firebase


@main
struct SecureSignGoogleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            InitialView()
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
