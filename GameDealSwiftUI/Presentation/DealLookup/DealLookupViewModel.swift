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
    let workerMetacritic = MetacriticServiceImplementation()
    
    // To fetch when get gameID
    @Published var gameLookupModel: GameLookupModel?
    
    // To recive from feed
    @Published var feedGameDealModel: FeedGameDealModel?
    @Published var metacriticDetailModel: MetacriticDetailModel?
    @Published var viewState: ViewState = .loading
    
    @Published var scrollPosition: CGPoint = .zero
    @Published var showNavigationTitle = false
    
    @MainActor
    func setupView(feedGameDealModel: FeedGameDealModel) async {
        self.feedGameDealModel = feedGameDealModel
        fetchStoresInformations()
        fetchDealLookup(gameID: feedGameDealModel.gameID)
        self.metacriticDetailModel = await fetchMetacriticDetailsInformation(metacriticLink: feedGameDealModel.metacriticLink ?? "")
    }
    
    func showNavigationTitleDescription() -> String {
        if showNavigationBar() {
            return ""
        }
        return feedGameDealModel?.title ?? "Unkow"
    }
    
    func showNavigationBar() -> Bool {
        if self.scrollPosition.y >= -5.0 {
            return true
        }
        return false
    }
    
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
    
    func formatSavings(_ savings: String) -> String {
        var savingFormatted = ""
        
        let index = savings.firstIndex(of: ".") ?? savings.endIndex
        
        let beginning = savings[..<index]
        
        savingFormatted = String(beginning)
        
        return savingFormatted
    }
    
    // MARK: - Metacritic
    @MainActor
    func fetchMetacriticDetailsInformation(metacriticLink: String) async -> MetacriticDetailModel{
        let baseURL = "https://www.metacritic.com"
        
        let url = baseURL + metacriticLink
        
        let data = await workerMetacritic.fetchDetailsInformation(metacriticLink: url)
        
        self.viewState = .loaded
        return data
    }
}
