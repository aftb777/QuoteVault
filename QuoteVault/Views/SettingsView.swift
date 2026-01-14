//
//  SettingsView.swift
//  QuoteVault
//
//

import SwiftUI

struct SettingsView: View {

    @EnvironmentObject var vm: SettingsViewModel

    var body: some View {
        Form {

            Section("Appearance") {
                Toggle("Dark Mode", isOn: $vm.darkMode)

                Slider(value: $vm.fontSize, in: 14...30, step: 1) {
                    Text("Font Size")
                }

                Text("Preview text size")
                    .font(.system(size: vm.fontSize))
            }
        }
        .navigationTitle("Settings")
        .onAppear { vm.load() }
        .onDisappear { vm.save() }
    }
}
