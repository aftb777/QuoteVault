//
//  UserProfile.swift
//  QuoteVault
//
//  Created by Aftaab Mulla on 13/01/26.
//

import Foundation

struct UserProfile: Codable {
    let id: String
    var name: String
    var theme: String
    var fontSize: Double
}
