//
//  FavoritesView.swift
//  QuoteVault
//
//  Created by Aftaab Mulla on 13/01/26.
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
