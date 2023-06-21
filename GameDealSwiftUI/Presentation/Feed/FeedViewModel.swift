//
//  FeedViewModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 19/06/23.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    // Published Properties
    @Published var dealsAAA = [FeedGameDealModel]()
    
    private var storesInformations = [StoresCheapShark]()
    
    private let workerCheapShark = WorkerCheapShark()
    
    // Funcs
    func displayDeaslAAA() {
        let endpoint = EndpointCasesCheapShark.getDealsList(pageNumber: 0, pageSize: 10, sortList: .RECENT, AAA: true, storeID: nil)
        
        workerCheapShark.getDealsList(endpoint: endpoint) { result in
            switch result {
            case .success(let deals):
                DispatchQueue.main.async { [self] in
                    self.dealsAAA = deals
                }
            case .failure(let failure):
                // TODO: - Tratar erro
                print(failure)
            }
        }
    }

    func fetchStores() {
        workerCheapShark.getStores { result in
            switch result {
            case .success(let stores):
                DispatchQueue.main.async {
                    self.storesInformations = stores
                } 
            case .failure(let failure):
                // TODO: - Tratar erro
                print(" erro ao baixar store image - \(failure)")
            }
        }
    }
    
    func setupModel(_ model: FeedGameDealModel) -> FeedGameDealModel {
        let model = FeedGameDealModel(
            gameID: model.gameID,
            dealID: model.dealID,
            // TODO: - change to get store image
            storeID: getStoreImage(storeID: model.storeID),
            title: model.title,
            salePrice: "$\(model.salePrice)",
            normalPrice: "$\(model.normalPrice)",
            savings: formatSavings(model.savings),
            thumb: getHightQualityImage(url: model.thumb)
        )
        
        return model
    }
}

extension FeedViewModel {
    /// Replace url to another url with hight quality image
    /// - Parameter url: `String` with url with original quality
    /// - Returns: `String` url with hight quality image
    private func getHightQualityImage(url: String) -> String {
        return url.replacingOccurrences(of: "capsule_sm_120", with: "header")
    }
    
    private func getStoreImage(storeID: String) -> String {
        
        let store = self.storesInformations.first(where: {$0.storeID == storeID})
        
        // TODO: - return empty store icon
        guard let imageStore = store?.images.logo else { return "" }
        
        let baseURL = BaseURL.cheapsharkURL
        
        let finalImage = "\(baseURL)\(imageStore)"

        return finalImage
    }
    
    private func formatSavings(_ savings: String) -> String {
        var savingFormatted = ""
        
        let index = savings.firstIndex(of: ".") ?? savings.endIndex
        
        let beginning = savings[..<index]
        
        savingFormatted = String(beginning)
        
        return "-\(savingFormatted)%"
    }
}
