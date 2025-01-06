//
//  FormatterUseCaseImplementation.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 19/08/24.
//

import Foundation

struct FormatterUseCaseImplementation: FormatterProcol {
    
    // TODO: - Adicionar forma para colocar imagens de outras fontes também
    
    /// Replace url to another url with hight quality image
    /// - Parameter url: `String` with url with original quality
    /// - Returns: `String` url with hight quality image
    func getHightQualityImage(url: String) async -> String {
        if url.contains("capsule_sm_120") {
            let highImage = url.replacingOccurrences(of: "capsule_sm_120", with: "header")

            if await checkUrlHasContent(highImage) {
                return highImage
            }
        }
        return url
    }
    
    /// Get store banner
    /// - Parameter storeID: `ID` from Store
    /// - Returns: `String` contains url logo image
    func getStoreImage(store: StoresCheapShark) -> String {

        let logo = store.images.logo
        
        let baseURL = BaseURL.cheapsharkURL
        
        let finalImage = "\(baseURL)\(logo)"

        return finalImage
    }
    
    /// Formatte Savings data
    /// - Parameter savings: `String` with data
    /// - Returns: `String` saving formatted like: "-90%"
    func formatSavings(_ savings: String) -> String {
        var savingFormatted = ""
        
        let index = savings.firstIndex(of: ".") ?? savings.endIndex
        
        let beginning = savings[..<index]
        
        savingFormatted = String(beginning)
        
        return savingFormatted
    }
    
    /// Compare original and current price to check is on sale
    /// - Parameters:
    ///   - originalPrice: `String` originial price
    ///   - currentPrice: `String` current price
    /// - Returns: is on sale
    func isOnSale(originalPrice: String?, currentPrice: String?) -> Bool {
        guard let original = Double(originalPrice!) else { return false }
        guard let current = Double(currentPrice!) else { return false }
        return current < original
    }
    
    /// Remove all 'description' title from original description
    /// - Parameter description: original description
    /// - Returns: description formatted
    func descriptionFormatted(description: String) -> String {
        var formatted = description
        formatted = formatted.replacingOccurrences(of: "Description:", with: "")
        formatted = formatted.replacingOccurrences(of: "DESCRIPTION:", with: "")
        formatted = formatted.trimmingCharacters(in: .whitespacesAndNewlines)
        return formatted
    }

    func checkUrlHasContent(_ urlString: String) async -> Bool {
        guard let url = URL(string: urlString) else {
            return false
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, !data.isEmpty {
                return true
            } else {
                return false
            }
        } catch {
            print("URL access error: \(error.localizedDescription)")
            return false
        }
    }
}
