//
//  QuoteViewModel.swift
//  QuoteVault
//
//

import Foundation
import Supabase
import Combine

@MainActor
final class QuoteViewModel: ObservableObject {

    @Published var quotes: [Quote] = []
    @Published var dailyQuote: Quote?

    private let supabase = SupabaseManager.shared.client

    // MARK: - Load all quotes
    func loadQuotes() async {
        do {
            let result: [Quote] = try await supabase
                .from("quotes")
                .select()
                .execute()
                .value

            print("🔥 Quotes fetched:", result.count)
            self.quotes = result

        } catch {
            print("❌ Load quotes error:", error.localizedDescription)
            self.quotes = []
        }
    }

    // MARK: - Search quotes
    func search(_ text: String) async {
        guard !text.isEmpty else {
            await loadQuotes()
            return
        }

        do {
            let result: [Quote] = try await supabase
                .from("quotes")
                .select()
                .ilike("content", pattern: "%\(text)%")
                .execute()
                .value

            self.quotes = result

        } catch {
            print("❌ Search error:", error.localizedDescription)
        }
    }

    // MARK: - Daily quote (safe)
    func loadDailyQuote() async {
        do {
            let all: [Quote] = try await supabase
                .from("quotes")
                .select()
                .execute()
                .value

            guard !all.isEmpty else {
                dailyQuote = nil
                print("⚠️ No quotes in database yet")
                return
            }

            let index = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 1
            dailyQuote = all[index % all.count]

        } catch {
            print("❌ Daily quote error:", error.localizedDescription)
            dailyQuote = nil
        }
    }
}
