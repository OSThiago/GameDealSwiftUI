//
//  FormatterProtocol.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 19/08/24.
//

import Foundation

protocol FormatterProcol {
    func getHightQualityImage(url: String) async -> String
    func getStoreImage(store: StoresCheapShark) -> String
    func formatSavings(_ savings: String) -> String
    func isOnSale(originalPrice: String?, currentPrice: String?) -> Bool
    func descriptionFormatted(description: String) -> String
    func checkUrlHasContent(_ urlString: String) async -> Bool
}
