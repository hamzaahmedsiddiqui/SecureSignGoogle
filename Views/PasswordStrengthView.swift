//
//  PasswordStrengthView.swift
//  SecureSignGoogle
//
//  Created by hamza Ahmed on 2025-10-21.
//

import SwiftUI

struct PasswordStrengthView: View {
    let password: String

    private var strength: (label: String, score: Int, color: Color) {
        var score = 0
        if password.count >= 6 { score += 1 }
        if password.range(of: #"[A-Z]"#, options: .regularExpression) != nil { score += 1 }
        if password.range(of: #"[0-9]"#, options: .regularExpression) != nil { score += 1 }
        if password.range(of: #"[^\w]"#, options: .regularExpression) != nil { score += 1 }

        switch score {
        case 0...1: return ("Weak", score, .red)
        case 2:     return ("Okay", score, .orange)
        case 3:     return ("Good", score, .yellow)
        default:    return ("Strong", score, .green)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack(alignment: .leading) {
                Capsule().fill(Color(.tertiarySystemFill)).frame(height: 6)
                Capsule().fill(strength.color)
                    .frame(width: CGFloat(strength.score) / 4.0 * 200, height: 6)
                    .animation(.easeOut(duration: 0.25), value: strength.score)
            }
            .frame(maxWidth: 200, alignment: .leading)
            Text("Strength: \(strength.label)")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 2)
    }
}
