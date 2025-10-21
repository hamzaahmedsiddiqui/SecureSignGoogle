//
//  DashboardViewModel.swift
//  SecureSignGoogle
//
//  Created by hamza Ahmed on 2025-10-21.
//


import Foundation
import Combine
import GoogleSignIn
import FirebaseAuth


class DashboardViewModel: ObservableObject {
    
    func logout() async throws{
        GIDSignIn.sharedInstance.signOut()
        try Auth.auth().signOut()
    }
}
