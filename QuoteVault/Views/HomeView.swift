//
//  HomeView.swift
//  QuoteVault
//
//  Created by Aftaab Mulla on 13/01/26.
//

import SwiftUI

struct HomeView: View {

    @StateObject var vm = QuoteViewModel()

    var body: some View {
        NavigationStack {
            List(vm.quotes) { quote in
                QuoteCard(quote: quote)
            }
            .navigationTitle("Quotes")
            .task {
                await vm.loadQuotes()
                await vm.loadDailyQuote()
            }
            .refreshable { await vm.loadQuotes() }
        }
    }
}
