//
//  ListDealViewModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 25/06/23.
//

import SwiftUI

class ListDealViewModel: ObservableObject, FormatterDealData {
    
    @Published var dealList = [FeedGameDealModel]()
    
    var workerCheapShark = WorkerCheapShark()
    
    var storesInformations: [StoresCheapShark] = []
    
    var store: StoresCheapShark?
    
    func fetchDeals() {
        guard let store = self.store else { return }
        
        let endpoint = EndpointCasesCheapShark.getDealsList(pageNumber: 0, pageSize: 30, sortList: .RECENT, AAA: false, storeID: store.storeID)
        
        workerCheapShark.getDealsList(endpoint: endpoint) { result in
            switch result {
            case .success(let deals):
                DispatchQueue.main.async {
                    self.dealList = deals
                }
            case .failure(let failure):
                // TODO: - Tratar erro
                print(failure)
            }
        }
    }
}
