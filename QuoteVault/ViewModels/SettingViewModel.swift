//
//  SettingViewModel.swift
//  QuoteVault
//
//  Created by Aftaab Mulla on 13/01/26.
//

import Foundation
import Combine

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var darkMode = false
    @Published var fontSize: Double = 18

    func save() {
        UserDefaults.standard.set(darkMode, forKey: "dark")
        UserDefaults.standard.set(fontSize, forKey: "font")
    }

    func load() {
        darkMode = UserDefaults.standard.bool(forKey: "dark")
        fontSize = UserDefaults.standard.double(forKey: "font")
    }
}

