//
//  DealLookupViewModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 27/06/23.
//

import SwiftUI

final class DealLookupViewModel: ObservableObject, FormatterDealData {
    
    var storesInformations: [StoresCheapShark] = []
    
    let workerCheapShark = WorkerCheapShark()
    
    // To fetch when get gameID
    @Published var gameLookupModel: GameLookupModel?
    
    // To recive from feed
    @Published var feedGameDealModel: FeedGameDealModel?
    
    func fetchDealLookup(gameID: String) {
        
        let endpoint = EndpointCasesCheapShark.getGameLookup(gameID)
        
        workerCheapShark.getGameLookup(endpoint: endpoint) { result in
            switch result {
            case .success(let gameData):
                DispatchQueue.main.async {
                    self.gameLookupModel = gameData
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchStoresInformations() {
        if !storesInformations.isEmpty {
            return
        }
        
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
}
