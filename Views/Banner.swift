//
//  Banner.swift
//  SecureSignGoogle
//
//  Created by hamza Ahmed on 2025-10-21.
//

import SwiftUI

struct Banner: View {
    enum Style { case error, info }
    var text: String
    var style: Style

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Image(systemName: style == .error ? "xmark.octagon.fill" : "info.circle.fill")
            Text(text)
                .font(.footnote)
                .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(style == .error
                      ? Color.red.opacity(0.12)
                      : Color.blue.opacity(0.12))
        )
        .foregroundStyle(style == .error ? .red : .blue)
    }
}
