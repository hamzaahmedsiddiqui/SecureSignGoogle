//
//  LabeledField.swift
//  SecureSignGoogle
//
//  Created by hamza Ahmed on 2025-10-21.
//

import SwiftUI

struct LabeledField<Content: View, Footer: View>: View {
    var title: String
    var systemImage: String
    @ViewBuilder var content: () -> Content
    @ViewBuilder var footer: () -> Footer

    init(
        title: String,
        systemImage: String,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder footer: @escaping () -> Footer = { EmptyView() }
    ) {
        self.title = title
        self.systemImage = systemImage
        self.content = content
        self.footer = footer
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                Image(systemName: systemImage)
                    .foregroundStyle(.secondary)
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            content()
                .padding(.horizontal, 12)
                .frame(height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.secondarySystemBackground))
                )

            footer()
        }
    }
}
