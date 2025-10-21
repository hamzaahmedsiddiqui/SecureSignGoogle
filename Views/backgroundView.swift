//
//  backgroundView.swift
//  SecureSignGoogle
//
//  Created by hamza Ahmed on 2025-10-21.
//

import SwiftUI

struct backgroundView: View {
    var body: some View {
        LinearGradient(
            colors: [Color.blue.opacity(0.15), Color.purple.opacity(0.12)],
            startPoint: .topLeading, endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

#Preview {
    backgroundView()
}
