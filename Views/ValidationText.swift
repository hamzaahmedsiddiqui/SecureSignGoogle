//
//  ValidationText.swift
//  SecureSignGoogle
//
//  Created by hamza Ahmed on 2025-10-21.
//

import SwiftUI

 struct ValidationText: View {
    var text: String
    init(_ text: String) { self.text = text }
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.caption)
                .foregroundStyle(.orange)
            Text(text)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 2)
    }
}
