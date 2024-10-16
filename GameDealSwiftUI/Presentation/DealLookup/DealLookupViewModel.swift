//
//  DealLookupViewModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 27/06/23.
//

import SwiftUI

// TODO: - adicionar use case de formatação

final class DealLookupViewModel: ObservableObject {
    
    @Injected var ServiceMetacritic: MetacriticServiceProtocol
    @Injected var ServiceCheapShark: CheapSharkServiceProtocol
    @Injected var FormatterUseCase: FormatterProcol
    
    let feedGameDealModel: FeedGameDealModel
    let store: StoresCheapShark
    
    @Published var gameLookupModel: GameLookupModel?
    @Published var storesInformations: [StoresCheapShark] = []
    @Published var metacriticDetailModel: MetacriticDetailModel?
    @Published var viewState: ViewState = .loading
    @Published var scrollPosition: CGPoint = .zero
    @Published var showNavigationTitle = false
    
    init(
        feedGameDealModel: FeedGameDealModel,
        store: StoresCheapShark
    ) {
        self.feedGameDealModel = feedGameDealModel
        self.store = store
    }
    
    @MainActor
    func viewDidLoad() async {
        fetchStoresInformations()
        fetchDealLookup(gameID: self.feedGameDealModel.gameID)
        self.metacriticDetailModel = await fetchMetacriticDetailsInformation(metacriticLink: feedGameDealModel.metacriticLink ?? "")
    }
    
    func showNavigationTitleDescription() -> String {
        if showNavigationBar() {
            return ""
        }
        return feedGameDealModel.title
    }
    
    func showNavigationBar() -> Bool {
        if self.scrollPosition.y >= -5.0 {
            return true
        }
        return false
    }
    
    func fetchDealLookup(gameID: String) {
        
        let endpoint = EndpointCasesCheapShark.getGameLookup(gameID)
        
        ServiceCheapShark.getGameLookup(endpoint: endpoint) { result in
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
        
        ServiceCheapShark.getStores { result in
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

    func isCheaper(chepeast: String?, value: String?) -> Bool {
        guard let cheapestDouble = Double(chepeast!) else { return false }
        guard let valueDouble = Double(value!) else { return false }
        
        if valueDouble <= cheapestDouble {
            return true
        }
        
        return false
    }
    
    func getStore(storeID: String) -> StoresCheapShark? {
        return storesInformations.first(where: { $0.storeID == storeID })
    }
    
    // MARK: - Metacritic
    @MainActor
    func fetchMetacriticDetailsInformation(metacriticLink: String) async -> MetacriticDetailModel{
        let baseURL = "https://www.metacritic.com"
        
        let url = baseURL + metacriticLink
        
        let data = await ServiceMetacritic.fetchDetailsInformation(metacriticLink: url)
        
        self.viewState = .loaded
        return data
    }
}
