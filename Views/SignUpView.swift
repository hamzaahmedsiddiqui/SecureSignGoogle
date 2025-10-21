//
//  SignUpView.swift
//  SecureSignGoogle
//
//  Created by hamza Ahmed on 2025-10-21.
//

import SwiftUI

struct SignUpView: View {
    // Form fields
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var agreeToTerms = false
    @State private var showPassword = false
    
    // UI state
    @State private var isLoading = false
    @State private var errorMsg: String?
    @State private var infoMsg: String?
    
    // ViewModel you already have
    @ObservedObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                backgroundView()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Header
                        VStack(spacing: 6) {
                            Text("Create your account")
                                .font(.system(size: 28, weight: .bold))
                                .multilineTextAlignment(.center)
                            Text("One secure login for everything")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.top, 32)
                        
                        // Card
                        VStack(spacing: 16) {
                            // Name
                            LabeledField(
                                title: "Name (optional)",
                                systemImage: "person",
                                content: {
                                    TextField("Jane Appleseed", text: $name)
                                        .textContentType(.name)
                                        .submitLabel(.next)
                                }
                            )
                            
                            // Email
                            LabeledField(
                                title: "Email",
                                systemImage: "envelope",
                                content: {
                                    TextField("name@example.com", text: $email)
                                        .keyboardType(.emailAddress)
                                        .textInputAutocapitalization(.never)
                                        .autocorrectionDisabled()
                                        .textContentType(.emailAddress)
                                        .submitLabel(.next)
                                },
                                footer: {
                                    if !email.isEmpty && !email.isValidEmail() {
                                        ValidationText("Please enter a valid email")
                                    }
                                }
                            )
                            
                            // Password
                            LabeledField(
                                title: "Password",
                                systemImage: "lock",
                                content: {
                                    Group {
                                        if showPassword {
                                            TextField("Minimum 6 characters", text: $password)
                                        } else {
                                            SecureField("Minimum 6 characters", text: $password)
                                        }
                                    }
                                    .textContentType(.newPassword)
                                    .submitLabel(.done)
                                },
                                footer: {
                                    if !password.isEmpty {
                                        PasswordStrengthView(password: password)
                                    }
                                }
                            )
                            
                            // Terms
                            Toggle(isOn: $agreeToTerms) {
                                Text("I agree to the Terms and Privacy Policy")
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                            }
                            .toggleStyle(.switch)
                            
                            // Error / Info banners
                            if let e = errorMsg, !e.isEmpty {
                                Banner(text: e, style: .error)
                            }
                            if let m = infoMsg, !m.isEmpty {
                                Banner(text: m, style: .info)
                            }
                            
                            // Primary button
                            Button(action: createAccount) {
                                HStack {
                                    Spacer()
                                    Text("Create account")
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                                .frame(height: 48)
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                            .foregroundStyle(.white)
                            .background(isCreateDisabled ? Color.gray : Color.blue)
                            .cornerRadius(12)
                            .disabled(isCreateDisabled)
                            
                        }
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(Color(.systemBackground))
                                .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 8)
                        )
                        .padding(.horizontal)
                        .padding(.bottom, 24)
                    }
                }
                
                // Loading overlay
                if isLoading {
                    Color.black.opacity(0.15).ignoresSafeArea()
                    ProgressView("Creating your account…")
                        .padding(16)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemBackground)))
                        .shadow(radius: 8)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") { hideKeyboard() }
                }
            }
            .navigationTitle("") // cleaner header
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Helpers
    private var isCreateDisabled: Bool {
        isLoading
        || email.isEmpty
        || !email.isValidEmail()
        || password.count < 6
        || !agreeToTerms
    }
    
    private func createAccount() {
        errorMsg = nil
        infoMsg = nil
        isLoading = true
        
        viewModel.signUp(email: email, password: password, displayName: name) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success:
                    errorMsg = nil
                    infoMsg = "A verification link has been sent to your email."
                    // Optionally clear password
                    password = ""
                case .failure(let err):
                    errorMsg = err.localizedDescription
                }
            }
        }
    }
    
    private func hideKeyboard() {
#if canImport(UIKit)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
#endif
    }
}

#Preview {
    NavigationStack { SignUpView() }
}
