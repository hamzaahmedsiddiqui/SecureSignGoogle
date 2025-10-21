//
//  Application.swift
//  SecureSignGoogle
//
//  Created by hamza Ahmed on 2025-10-18.
//

import SwiftUI

class Application_utility {
    static var rootViewController: UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root =  screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
