//
//  QuoteVaultApp.swift
//  QuoteVault
//
//

import SwiftUI
import Supabase

@main
struct QuoteVaultApp: App {

    @StateObject var authVM = AuthViewModel()
    @StateObject var settingsVM = SettingsViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authVM)
                .environmentObject(settingsVM)
                .preferredColorScheme(settingsVM.darkMode ? .dark : .light)
                .task {
                    await authVM.checkSession()
                    settingsVM.load()
                }
        }
    }
}

