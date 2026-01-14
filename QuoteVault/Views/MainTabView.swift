//
//  MainTabView.swift
//  QuoteVault
//
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView().tabItem { Label("Home", systemImage: "house") }
            FavoritesView().tabItem { Label("Favorites", systemImage: "heart") }
            SettingsView().tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}
