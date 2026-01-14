//
//  FavoritesView.swift
//  QuoteVault
//
//

import SwiftUI

struct FavoritesView: View {

    @EnvironmentObject var authVM: AuthViewModel
    @StateObject var favVM = FavoritesViewModel()

    var body: some View {
        List(favVM.favorites) { quote in
            QuoteCard(quote: quote)
        }
        .task {
            if let id = authVM.userId {
                await favVM.load(userId: id)
            }
        }
        .navigationTitle("Favorites")
    }
}
