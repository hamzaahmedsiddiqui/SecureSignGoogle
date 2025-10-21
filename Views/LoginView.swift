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
    @State private var isLoggedIn: Bool = false
    @State private var loginError: String = ""
    
    // MARK: - Initializer
    init(viewModel: LoginViewModel = LoginViewModel(), text: String = "") {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            // Background
            ZStack{
                // Background
                LinearGradient(
                    colors: [Color.blue.opacity(0.15), Color.purple.opacity(0.12)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack () {
                    VStack(spacing: 6) {
                        Text("Login In")
                            .font(.system(size: 28, weight: .bold))
                            .multilineTextAlignment(.center)
                        Text("One secure login for everything")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 32)
                    
                    
                    LabeledField(
                        title: "Email",
                        systemImage: "envelope",
                        content: {
                            TextField("name@example.com", text: $viewModel.email)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .textContentType(.emailAddress)
                                .submitLabel(.next)
                        },
                        footer: {
                            if !viewModel.email.isEmpty && !viewModel.email.isValidEmail() {
                                ValidationText("Please enter a valid email")
                            }
                        }
                    ).padding(.bottom).padding(.top)
                    
                    LabeledField(
                        title: "Password",
                        systemImage: "envelope",
                        content: {
                            SecureField("Enter your password", text: $viewModel.password)
                                .keyboardType(.default)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .submitLabel(.next)
                        },
                        footer: {
                            NavigationLink(destination: ForgotPasswordView()){
                                Text("Forgot Password?")
                                    .foregroundStyle(Color.red)
                            }
                            .font(.footnote)
                        }
                    )
                    
                    
                    VStack(alignment: .leading){
                        Button(action: {
                            viewModel.loginWithFirebase()
                        }) {
                            Text("Login")
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .background(Color.blue)
                                .font(.system(size: 16, weight: .bold))                            .cornerRadius(10)
                        }
                        
                        NavigationLink(destination: SignUpView()){
                            Text("Don't have an account?")
                        }
                    }.padding(.top, 30)
                        .font(.footnote)
                    
                    Spacer()
                    Text("-- OR --")
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                    BeautifulGoogleButton {
                        viewModel.signInWithGoogle()
                    }
                    
                    
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
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
