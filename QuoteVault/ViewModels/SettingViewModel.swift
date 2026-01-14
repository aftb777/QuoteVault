//
//  SettingViewModel.swift
//  QuoteVault
//
//

import SwiftUI
import Combine

@MainActor
final class SettingsViewModel: ObservableObject {

    @Published var darkMode: Bool = false {
        didSet { applyTheme() }
    }

    @Published var fontSize: Double = 18

    private let darkKey = "dark_mode"
    private let fontKey = "font_size"

    func applyTheme() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }

        scene.windows.first?.overrideUserInterfaceStyle =
            darkMode ? .dark : .light
    }

    func save() {
        UserDefaults.standard.set(darkMode, forKey: darkKey)
        UserDefaults.standard.set(fontSize, forKey: fontKey)
    }

    func load() {
        darkMode = UserDefaults.standard.bool(forKey: darkKey)
        fontSize = UserDefaults.standard.double(forKey: fontKey)
        if fontSize == 0 { fontSize = 18 }
        applyTheme()
    }
}
