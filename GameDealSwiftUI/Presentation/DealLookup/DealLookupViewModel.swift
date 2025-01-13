//
//  DealLookupViewModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 27/06/23.
//

import SwiftUI

// TODO: - adicionar use case de formatação

final class DealLookupViewModel: ObservableObject {
    
    @Injected var serviceMetacritic: MetacriticServiceProtocol
    @Injected var serviceGameInfo: GamesProtocol
    @Injected var serviceStores: StoresProtocol
    @Injected var formatterUseCase: FormatterProcol

    
    let feedGameDealModel: FeedGameDealModel
    let store: StoresCheapShark
    
    @Published var gameLookupModel: GameLookupModel?
    @Published var storesInformations: [StoresCheapShark] = []
    @Published var metacriticDetailModel: MetacriticDetailModel?
    @Published var viewState: ViewState = .loading
    @Published var scrollPosition: CGPoint = .zero
    @Published var showNavigationTitle = false
    @Published var isFavorite: Bool = false
    @Published var isLoadingMetacritic = true
    
    init(
        feedGameDealModel: FeedGameDealModel,
        store: StoresCheapShark
    ) {
        self.feedGameDealModel = feedGameDealModel
        self.store = store
    }
    
    @MainActor
    func viewDidLoad() async {
        await fetchStoresInformations()
        await fetchDealLookup(gameID: self.feedGameDealModel.gameID)
        self.viewState = .loaded
        self.metacriticDetailModel = await fetchMetacriticDetailsInformation(metacriticLink: feedGameDealModel.metacriticLink ?? "")
        updateIsFavorite()
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
    
    @MainActor
    func fetchDealLookup(gameID: String) async {
        do {
            let endpoint = GamesEndPoint.gameLookup(id: gameID)
            let gameInfo = try await serviceGameInfo.gameLookup(endpoint: endpoint)
            DispatchQueue.main.async {
                self.gameLookupModel = gameInfo
            }
        } catch {
            print(error)
        }
    }

    @MainActor
    func fetchStoresInformations() async {
        do {
            let endpoint = StoresEndpoint.storesInformation
            let storesInfo = try await serviceStores.storesInformation(endpoint: endpoint)
            DispatchQueue.main.async {
                self.storesInformations = storesInfo
            }
        } catch {
            print(error)
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
    func fetchMetacriticDetailsInformation(metacriticLink: String) async -> MetacriticDetailModel? {
        let baseURL = "https://www.metacritic.com"
        
        let url = baseURL + metacriticLink
        
        let data = await serviceMetacritic.fetchDetailsInformation(metacriticLink: url)

        isLoadingMetacritic = false
        
        return data
    }
    
    func updateIsFavorite() {
        DispatchQueue.main.async {
            self.isFavorite = CoreDataUseCase.shared.containsFavoriteGame(gameID: self.feedGameDealModel.gameID)
        }
    }
    
    func favoriteAction() {
        do {
            if isFavorite {
                try CoreDataUseCase.shared.deleteFavoriteGame(gameID: feedGameDealModel.gameID)
            } else {
                try CoreDataUseCase.shared.addFavoriteGame(gameID: feedGameDealModel.gameID)
            }
            updateIsFavorite()
        } catch {
            print(error)
        }
    }
    
    func getRedirectLink() -> String {
        let baseURL = "https://www.cheapshark.com/redirect?dealID="
        return baseURL + feedGameDealModel.dealID
    }
    
    func reuseFeedGameDealModel(feedGameDealmodel:  FeedGameDealModel, dealModel: DealsGameLookupModel) -> FeedGameDealModel {
        return FeedGameDealModel(gameID: feedGameDealmodel.gameID,
                                 dealID: dealModel.dealID ?? "error",
                                 storeID: dealModel.storeID ?? "error",
                                 title: feedGameDealmodel.title,
                                 salePrice: dealModel.price ?? "error",
                                 normalPrice: dealModel.retailPrice ?? "error",
                                 savings: dealModel.savings ?? "error",
                                 thumb: feedGameDealmodel.thumb,
                                 metacriticLink: feedGameDealmodel.metacriticLink)
    }
}
