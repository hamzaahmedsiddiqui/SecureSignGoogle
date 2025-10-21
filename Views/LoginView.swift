//
//  ContentView.swift
//  SecureSignGoogle
//
//  Created by hamza Ahmed on 2025-10-13.
//

import SwiftUI
import GoogleSignInSwift
import FirebaseAuth
import Firebase
import GoogleSignIn

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var isLoggedIn: Bool = false
    @State private var loginError: String = ""
    
    // MARK: - Initializer
    init(viewModel: LoginViewModel = LoginViewModel(), text: String = "") {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter your username", text: $email)
                    .textFieldStyle(.roundedBorder)
                
                VStack(alignment: .leading) {
                    SecureField("Enter your password", text: $password)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(action: {login()
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(), action: {
                    viewModel.signInWithGoogle()
                })
                
                if loginError.isEmpty{
                    Text(loginError)
                        .foregroundColor(.red)
                        .padding()
                }
                
                NavigationLink(value: isLoggedIn){
                    EmptyView()
                }
                .navigationDestination(isPresented: $isLoggedIn){
                    DashboardView()
                        .navigationBarBackButtonHidden(true)
                }
                
            }
            .padding()
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password){authResult, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                return
            }
            
            isLoggedIn = true
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
