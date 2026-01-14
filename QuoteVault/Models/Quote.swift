//
//  Quote.swift
//  QuoteVault
//
//

import Foundation

struct Quote: Identifiable, Codable {
    let id: Int
    let content: String
    let author: String
    let category: String
}
