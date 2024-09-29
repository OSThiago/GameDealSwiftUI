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
    func getHightQualityImage(url: String) -> String {
        if url.contains("capsule_sm_120") {
            return url.replacingOccurrences(of: "capsule_sm_120", with: "header")
        } else {
            return url
        }
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
}
