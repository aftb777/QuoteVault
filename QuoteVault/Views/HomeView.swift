//
//  HomeView.swift
//  QuoteVault
//
//

import SwiftUI

struct HomeView: View {

    @StateObject private var vm = QuoteViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if vm.quotes.isEmpty {
                    ProgressView("Loading quotes...")
                } else {
                    List {
                        
                        if let daily = vm.dailyQuote {
                            Section("🌟 Quote of the Day") {
                                QuoteCard(quote: daily)
                            }
                        }

                        Section("All Quotes") {
                            ForEach(vm.quotes) { quote in
                                QuoteCard(quote: quote)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Quotes")
            .task {
                await vm.loadQuotes()
                await vm.loadDailyQuote()
            }
            .refreshable {
                await vm.loadQuotes()
                await vm.loadDailyQuote()
            }
        }
    }
}
