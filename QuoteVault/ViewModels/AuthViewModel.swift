//
//  AuthViewModel.swift
//  QuoteVault
//
//  Created by Aftaab Mulla on 13/01/26.
//

import Foundation
import Combine
import Auth
import Supabase

@MainActor
final class AuthViewModel: ObservableObject {

    @Published var isLoggedIn = false
    @Published var userId: String?
    @Published var userEmail: String?

    private let supabase = SupabaseManager.shared.client

    // Restore session
    func checkSession() async {
        do {
            let session = try await supabase.auth.session

            self.userId = session.user.id.uuidString
            self.userEmail = session.user.email
            self.isLoggedIn = true

        } catch {
            // No active session
            self.isLoggedIn = false
            self.userId = nil
            self.userEmail = nil
        }
    }


    // Email Login
    func login(email: String, password: String) async throws {
        let response = try await supabase.auth.signIn(
            email: email,
            password: password
        )

        self.userId = response.user.id.uuidString
        self.userEmail = response.user.email
        self.isLoggedIn = true
    }

    // Email Signup
    func signup(email: String, password: String) async throws {
        let response = try await supabase.auth.signUp(
            email: email,
            password: password
        )

        self.userId = response.user.id.uuidString
        self.userEmail = response.user.email
        self.isLoggedIn = true
    }

    // Reset password
    func resetPassword(email: String) async throws {
        try await supabase.auth.resetPasswordForEmail(email)
    }

    // Logout
    func logout() async {
        try? await supabase.auth.signOut()
        self.isLoggedIn = false
        self.userId = nil
        self.userEmail = nil
    }
}

