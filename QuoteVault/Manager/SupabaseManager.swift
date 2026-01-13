//
//  SupabaseManager.swift
//  QuoteVault
//
//  Created by Aftaab Mulla on 13/01/26.
//

import Supabase
import Foundation

final class SupabaseManager {
    static let shared = SupabaseManager()

    let client = SupabaseClient(
        supabaseURL: URL(string: "YOUR_URL")!,
        supabaseKey: "YOUR_ANON_KEY"
    )
}
