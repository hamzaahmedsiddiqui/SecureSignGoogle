//
//  DashboardView.swift
//  SecureSignGoogle
//
//  Created by hamza Ahmed on 2025-10-18.
//

import SwiftUI

struct DashboardView: View {
    @State private var error: String = ""
    @StateObject private var viewModel = DashboardViewModel()
    var body: some View {
        Text("Dashboard")
        Button{
            Task{
                do {
                    try await viewModel.logout()
                } catch let err {
                    self.error = err.localizedDescription
                }
            }
        } label: {
            Text("Logout").padding(8)
        }.buttonStyle(.borderedProminent)
        Text(error)
            .padding(8)
            .foregroundColor(.red)
            .font(.caption)
    }
}

#Preview {
    DashboardView()
}
