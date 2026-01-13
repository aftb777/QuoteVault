//
//  QuoteViewModel.swift
//  QuoteVault
//
//  Created by Aftaab Mulla on 13/01/26.
//

import Foundation
import Combine
import Supabase

@MainActor
final class QuoteViewModel: ObservableObject {

    @Published var quotes: [Quote] = []
    @Published var dailyQuote: Quote?

    private let supabase = SupabaseManager.shared.client

    func loadQuotes() async {
        quotes = try! await supabase.from("quotes").select().execute().value
    }

    func loadCategory(_ category: String) async {
        quotes = try! await supabase
            .from("quotes")
            .select()
            .eq("category", value: category)
            .execute()
            .value
    }

    func search(_ text: String) async {
        quotes = try! await supabase
            .from("quotes")
            .select()
            .ilike("content", pattern: "%\(text)%")
            .execute()
            .value
    }

    func loadDailyQuote() async {
        let all: [Quote] = try! await supabase.from("quotes").select().execute().value
        let index = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 1
        dailyQuote = all[index % all.count]
    }
}
