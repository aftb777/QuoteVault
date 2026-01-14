//
//  UserProfile.swift
//  QuoteVault
//
//

import Foundation

struct UserProfile: Codable {
    let id: String
    var name: String
    var theme: String
    var fontSize: Double
}
