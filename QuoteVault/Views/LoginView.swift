//
//  LoginView.swift
//  QuoteVault
//
//

import SwiftUI

struct LoginView: View {

    @State private var email = ""
    @State private var password = ""
    @State private var error: String?
    @State private var loading = false
    @State private var showResetAlert = false

    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {

                Spacer()

                Text("QuoteVault")
                    .font(.largeTitle.bold())

                Text("Login with your email to continue")
                    .foregroundStyle(.secondary)

                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)

                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)

                if let error {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.footnote)
                }

                Button {
                    Task { await login() }
                } label: {
                    if loading {
                        ProgressView()
                    } else {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.blue)
                            .foregroundStyle(.white)
                            .cornerRadius(14)
                    }
                }

                Button("Forgot password?") {
                    showResetAlert = true
                }
                .font(.footnote)

                NavigationLink("Create new account", destination: SignupView())
                    .font(.footnote)

                Spacer()
            }
            .padding()
            .alert("Reset Password", isPresented: $showResetAlert) {
                Button("Send reset email") {
                    Task { await resetPassword() }
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("A password reset link will be sent to your email.")
            }
        }
    }

    private func login() async {
        error = nil
        loading = true
        defer { loading = false }

        do {
            try await authVM.login(email: email, password: password)
        } catch {
            self.error = error.localizedDescription
        }
    }

    private func resetPassword() async {
        guard !email.isEmpty else {
            error = "Enter your email first"
            return
        }

        do {
            try await authVM.resetPassword(email: email)
            error = "Password reset email sent ✅"
        } catch {
            print(error.localizedDescription)
        }
    }
}

