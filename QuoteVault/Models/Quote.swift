//
//  Quote.swift
//  QuoteVault
//
//  Created by Aftaab Mulla on 13/01/26.
//

import Foundation

struct Quote: Identifiable, Codable {
    let id: Int
    let content: String
    let author: String
    let category: String
}
