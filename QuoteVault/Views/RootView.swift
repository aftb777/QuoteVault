//
//  ContentView.swift
//  QuoteVault
//
//  Created by Aftaab Mulla on 13/01/26.
//

import SwiftUI

struct RootView: View {

    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        if authVM.isLoggedIn {
            MainTabView()
        } else {
            LoginView()
        }
    }
}

