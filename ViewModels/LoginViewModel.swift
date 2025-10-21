//
//  LoginViewModel.swift
//  SecureSignGoogle
//
//  Created by hamza Ahmed on 2025-10-17.
//

import Foundation
import Combine
import Firebase
import GoogleSignInSwift
import GoogleSignIn
import FirebaseAuth


class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoggedInSuccessfully: Bool = false
    @Published var isLoggedIn: Bool = false
    
    func signInWithGoogle() {
        guard let clientID =  FirebaseApp.app()?.options.clientID else {
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController){user, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard
                let user = user?.user,
                let idToken = user.idToken else {return}
            
            let accessToken =  user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: credential){res, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let user = res?.user else {return}
                print ("user: \(user)")
            }
        }
    }
    
    func loginWithFirebase() {
        Auth.auth().signIn(withEmail: email, password: password){authResult, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                return
            }
            
            self.isLoggedIn = true
        }
    }
}
