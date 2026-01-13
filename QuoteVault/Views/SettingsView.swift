//
//  SettingsView.swift
//  QuoteVault
//
//  Created by Aftaab Mulla on 13/01/26.
//

import SwiftUI

struct SettingsView: View {

    @StateObject var vm = SettingsViewModel()

    var body: some View {
        Form {
            Toggle("Dark Mode", isOn: $vm.darkMode)
            Slider(value: $vm.fontSize, in: 14...30) {
                Text("Font Size")
            }
        }
        .onDisappear { vm.save() }
        .onAppear { vm.load() }
        .navigationTitle("Settings")
    }
}
