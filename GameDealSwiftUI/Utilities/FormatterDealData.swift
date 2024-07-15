//
//  FormatterDealData.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 26/06/23.
//

import Foundation

protocol FormatterDealData {
    var storesInformations: [StoresCheapShark] { get set }
    
    func getHightQualityImage(url: String) -> String
    func getStoreImage(storeID: String) -> String
    func formatSavings(_ savings: String) -> String
}

extension FormatterDealData {
    /// Setup dell with formatted data
    /// - Parameter model: `FeedGameDealModel` data
    /// - Returns: `FeedGameDealModel` formatted
    func setupDealCell(_ model: FeedGameDealModel) -> FeedGameDealModel {
        let model = FeedGameDealModel(
            gameID: model.gameID,
            dealID: model.dealID,
            storeID: getStoreImage(storeID: model.storeID),
            title: model.title,
            salePrice: "$\(model.salePrice)",
            normalPrice: "$\(model.normalPrice)",
            savings: formatSavings(model.savings),
            thumb: getHightQualityImage(url: model.thumb), 
            metacriticLink: model.metacriticLink
        )
        return model
    }
    
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
    /// - Returns: `String` contains url image
    func getStoreImage(storeID: String) -> String {
        
        let store = self.storesInformations.first(where: {$0.storeID == storeID})
        
        // TODO: - return empty store icon
        guard let imageStore = store?.images.logo else { return "" }
        
        let baseURL = BaseURL.cheapsharkURL
        
        let finalImage = "\(baseURL)\(imageStore)"

        return finalImage
    }
    
    /// Serach store into stores list
    /// - Parameter id: `String` store ID
    /// - Returns: `StoreCheapShark` if contains or nil
    func getStore(id: String) -> StoresCheapShark? {
        return self.storesInformations.first(where: { $0.storeID == id})
    }
    
    /// Formatte Savings data
    /// - Parameter savings: `String` with data
    /// - Returns: `String` saving formatted like: "-90%"
    func formatSavings(_ savings: String) -> String {
        var savingFormatted = ""
        
        let index = savings.firstIndex(of: ".") ?? savings.endIndex
        
        let beginning = savings[..<index]
        
        savingFormatted = String(beginning)
        
        return "-\(savingFormatted)%"
    }
}
