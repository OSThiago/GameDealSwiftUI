//
//  FeedViewModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 19/06/23.
//

import SwiftUI

class FeedViewModel: ObservableObject, FormatterDealData {
    // Published Properties
    @Published var dealsAAA = [FeedGameDealModel]()
    
    @Published var storesDeals: [(store: StoresCheapShark, dealsList:[FeedGameDealModel])] = []
    
    @Published var storesInformations = [StoresCheapShark]()
    
    private let workerCheapShark = WorkerCheapShark()
    
    // Funcs
    func fetchStores() {
        
        if !storesInformations.isEmpty {
            return
        }
        
        workerCheapShark.getStores { result in
            switch result {
            case .success(let stores):
                DispatchQueue.main.async {
                    self.storesInformations = stores
                    self.displayDealsStores()
                }
            case .failure(let failure):
                // TODO: - Tratar erro
                print(" erro ao baixar store image - \(failure)")
            }
        }
    }
    
    func displayDealsAAA() {
        
        if !dealsAAA.isEmpty {
            return
        }
        
        let endpoint = EndpointCasesCheapShark.getDealsList(pageNumber: 0, pageSize: 8, sortList: .DEALRATING, AAA: true, storeID: nil)
        
        workerCheapShark.getDealsList(endpoint: endpoint) { result in
            switch result {
            case .success(let deals):
                DispatchQueue.main.async { [self] in
                    
                    var filtered = [FeedGameDealModel]()
                    
                    for deal in deals {
                        if !filtered.contains(where: { $0.title == deal.title }) {
                            filtered.append(deal)
                        }
                    }
                    
                    self.dealsAAA = filtered
                }
            case .failure(let failure):
                // TODO: - Tratar erro
                print(failure)
            }
        }
    }
    
    func displayDealsStores() {
        let selectedStores = ["Steam", "Epic Games Store", "Uplay" , "GOG"]
        
        if !storesDeals.isEmpty {
            return
        }
        
        for selectedStore in selectedStores {
            
            guard let store = storesInformations.first(where: {$0.storeName == selectedStore}) else { return }
            
            let endpoint = EndpointCasesCheapShark.getDealsList(pageNumber: 0, pageSize: 10, sortList: .PRICE, AAA: false, storeID: store.storeID)
            
            workerCheapShark.getDealsList(endpoint: endpoint) { result in
                switch result {
                case .success(let deals):
                    DispatchQueue.main.async {
                        self.storesDeals.append((store: store, dealsList: deals))
                    }
                case .failure(let failure):
                    // TODO: - Tratar erro
                    print(failure)
                }
            }
        }
    }
    
    func setupDealCell(_ model: FeedGameDealModel) -> FeedGameDealModel {
        let model = FeedGameDealModel(
            gameID: model.gameID,
            dealID: model.dealID,
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
