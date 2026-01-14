//
//  SupabaseManager.swift
//  QuoteVault
//
//

import Supabase
import Foundation

final class SupabaseManager {
    static let shared = SupabaseManager()

    let client = SupabaseClient(
        supabaseURL: URL(string: "Your_Api_Key")!,
        supabaseKey: "Your_Anon_Key"
    )
}
