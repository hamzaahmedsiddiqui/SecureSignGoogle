//
//  ForgotPasswordViewModel.swift
//  SecureSignGoogle
//
//  Created by hamza Ahmed on 2025-10-21.
//


import FirebaseAuth
import SwiftUI
import Combine


final class ForgotPasswordViewModel: ObservableObject {
    @Published var email = ""
    @Published var isSending = false
    @Published var info: String = ""
    @Published var error: String = ""

    func sendReset() {
        info = ""; error = ""; isSending = true
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] err in
            DispatchQueue.main.async {
                self?.isSending = false
                if let err = err {
                    self?.error = err.localizedDescription
                } else {
                    self?.info = "If an account exists for \(self?.email ?? ""), a reset link has been sent."
                }
            }
        }
    }
}
