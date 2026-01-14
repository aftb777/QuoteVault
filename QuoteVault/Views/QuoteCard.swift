//
//  QuoteCard.swift
//  QuoteVault
//
//

import SwiftUI

struct QuoteCard: View {

    let quote: Quote

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("“\(quote.content)”").font(.title3)
            Text("- \(quote.author)").foregroundStyle(.secondary)
        }
        .padding()
    }
}
