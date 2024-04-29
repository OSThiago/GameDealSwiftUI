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
    
    let workerRawg = WorkerRAWG()
    
    // To fetch when get gameID
    @Published var gameLookupModel: GameLookupModel?
    
    // To recive from feed
    @Published var feedGameDealModel: FeedGameDealModel?
    
    // Contains list of games searched by game name
    @Published var searchGamesModel: RwSearchGameModel?
    
    @Published var rwGameDetail: RwGameDetailModel?
    
    @MainActor
    func setupView(feedGameDealModel: FeedGameDealModel) async {
        self.feedGameDealModel = feedGameDealModel
        await fetchStoresInformations()
        await fetchDealLookup(gameID: feedGameDealModel.gameID)
        await fetchGameDetailFromRawg()
        await fetchSearchDetailRawg(gameName: feedGameDealModel.title)
    }
    
    @MainActor
    func fetchDealLookup(gameID: String) async {
        
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
    
    @MainActor
    func fetchStoresInformations() async {

        guard storesInformations.isEmpty else { return }
        
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
    
    @MainActor
    func fetchGameDetailFromRawg() async {
        guard let gameNameReplaced = self.feedGameDealModel?.title.replacingOccurrences(of: " ", with: "-") else { return }
        
        let endpoint = EndpointCasesRAWG.getGameDetail(name: gameNameReplaced.lowercased())
        
        //print(endpoint.url)
        
        workerRawg.getGameDetail(endpoint: endpoint) { result in
            switch result {
            case .success(let gameDetail):
                DispatchQueue.main.async {
                    self.rwGameDetail = gameDetail
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    @MainActor
    func fetchSearchDetailRawg(gameName: String) async {
        
        let gameNameReplaced = gameName.replacingOccurrences(of: " ", with: "+")
        
        let endpoint = EndpointCasesRAWG.searchGame(name: gameNameReplaced.lowercased())
        
        //print(endpoint.url)
        
        workerRawg.searchGame(endpoint: endpoint) { result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.searchGamesModel = result
                }
            case .failure(let failure):
                // TODO: - Create error feedback
                print(failure)
            }
        }
    }
}
