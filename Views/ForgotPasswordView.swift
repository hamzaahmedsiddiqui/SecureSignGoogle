//
//  ForgotPasswordView.swift
//  SecureSignGoogle
//
//  Created by hamza Ahmed on 2025-10-21.
//
import SwiftUI


struct ForgotPasswordView: View {
    @StateObject private var vm = ForgotPasswordViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text("Reset your password").font(.title2).bold()

            TextField("Email", text: $vm.email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)

            Button {
                vm.sendReset()
            } label: {
                Text(vm.isSending ? "Sending…" : "Send reset link")
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(vm.email.isEmpty ? Color.gray : Color.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
            }
            .disabled(vm.email.isEmpty || vm.isSending)

            if !vm.info.isEmpty {
                Text(vm.info).foregroundStyle(.green)
            }
            if !vm.error.isEmpty {
                Text(vm.error).foregroundStyle(.red)
            }

            Spacer()
        }
        .padding()
    }
}
