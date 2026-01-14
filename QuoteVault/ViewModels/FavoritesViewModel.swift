//
//  FavoritesViewModel.swift
//  QuoteVault
//
//

import Combine
import Foundation
import Supabase

struct FavoriteInsert: Encodable {
    let user_id: String
    let quote_id: Int
}

struct FavoriteRow: Decodable {
    let quotes: Quote
}


@MainActor
final class FavoritesViewModel: ObservableObject {

    @Published var favorites: [Quote] = []

    private let supabase = SupabaseManager.shared.client


    func load(userId: String) async {
        do {
            let response: PostgrestResponse<[FavoriteRow]> = try await supabase
                .from("favorites")
                .select("quotes(*)")
                .eq("user_id", value: userId)
                .execute()

            self.favorites = response.value.map { $0.quotes }

        } catch {
            print("❌ Load favorites error:", error.localizedDescription)
        }
    }

    func add(userId: String, quoteId: Int) async {
        do {
            let fav = FavoriteInsert(user_id: userId, quote_id: quoteId)

            try await supabase
                .from("favorites")
                .insert(fav)
                .execute()

        } catch {
            print("❌ Add favorite error:", error.localizedDescription)
        }
    }


    func remove(userId: String, quoteId: Int) async {
        do {
            try await supabase
                .from("favorites")
                .delete()
                .eq("user_id", value: userId)
                .eq("quote_id", value: quoteId)
                .execute()
        } catch {
            print("❌ Remove favorite error:", error.localizedDescription)
        }
    }
}
