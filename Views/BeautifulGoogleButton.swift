//
//  BeautifulGoogleButton.swift
//  SecureSignGoogle
//
//  Created by hamza Ahmed on 2025-10-21.
//

import SwiftUI

struct BeautifulGoogleButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image("google_logo") // add an official Google "G" in Assets (24x24)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Text("Continue with Google")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
            )
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.25), lineWidth: 1)
        )
    }
}
