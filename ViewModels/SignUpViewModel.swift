//
//  SignUpViewModel.swift
//  SecureSignGoogle
//
//  Created by hamza Ahmed on 2025-10-21.
//

import Foundation
import Combine
import SwiftUI
import FirebaseAuth


class SignUpViewModel:ObservableObject{
    
    func signUp(email: String, password: String, displayName: String? = nil, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error { return completion(.failure(error)) }
            guard let user = result?.user else { return }

            // Optional: set display name
            if let displayName {
                let change = user.createProfileChangeRequest()
                change.displayName = displayName
                change.commitChanges { _ in completion(.success(user)) }
            } else {
                completion(.success(user))
            }

            // Optional: send verification email
            user.sendEmailVerification(completion: nil)
        }
    }
    
}
