//
//  InitialView.swift
//  SecureSignGoogle
//
//  Created by hamza Ahmed on 2025-10-18.
//

import SwiftUI
import FirebaseAuth

struct InitialView: View {
    @State private var userLoggedIn = (Auth.auth().currentUser != nil)
    @State private var authListenerHandle: AuthStateDidChangeListenerHandle?
    
    var body: some View {
        VStack{
            if userLoggedIn {
                DashboardView()
            }else {
                LoginView()
            }
        }.onAppear(){
            authListenerHandle = Auth.auth().addStateDidChangeListener {_, user in
                userLoggedIn = (user != nil)
            }
        }
        .onDisappear {
            if let handle = authListenerHandle {
                Auth.auth().removeStateDidChangeListener(handle)
            }
        }
    }
}

#Preview {
    InitialView()
}
