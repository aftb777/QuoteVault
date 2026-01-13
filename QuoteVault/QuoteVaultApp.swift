//
//  QuoteVaultApp.swift
//  QuoteVault
//
//  Created by Aftaab Mulla on 13/01/26.
//

import SwiftUI
import Supabase

@main
struct QuoteVaultApp: App {

    @StateObject var authVM = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authVM)
                .task { await authVM.checkSession() }
        }
    }
}
