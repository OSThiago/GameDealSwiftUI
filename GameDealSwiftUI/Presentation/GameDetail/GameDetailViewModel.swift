//
//  GameDetailViewModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 08/11/24.
//

import Foundation

protocol GameDetailViewModelProtocol {
    func viewDidLoad() async
    func fetchGameDetails() async
    func isCheaper(value: String?) -> Bool
    func updateIsFavorite()
    func favoriteAction()
    
    var gameId: String { get }
    var gameLookupModel: GameLookupModel? { get set }
    var metacriticDetailModel: MetacriticDetailModel? { get set }
    var isLoading: Bool { get set }
    var isLoadingMetacritic: Bool { get set }
    var hasPerformedAction: Bool { get set }
}

final class GameDetailViewModel: ObservableObject, GameDetailViewModelProtocol {
    
    @Injected var gamesService: GamesProtocol
    @Injected var serviceStores: StoresProtocol
    @Injected var serviceMetacritic: MetacriticServiceProtocol
    @Injected var formatterUseCase: FormatterProcol
    
    @Published var gameLookupModel: GameLookupModel?
    @Published var metacriticDetailModel: MetacriticDetailModel?
    @Published var storesInformations: [StoresCheapShark] = []
    @Published var isLoading: Bool = true
    @Published var isFavorite: Bool = false
    @Published var isLoadingMetacritic = true
    @Published var hasPerformedAction = false
    
    let gameId: String
    
    init(gameid: String) {
        self.gameId = gameid
    }
    
    @MainActor
    func viewDidLoad() async {
        
        updateIsFavorite()
        
        await fetchGameDetails()
        
        await fetchStoresInformations()
        
        DispatchQueue.main.async {
            self.isLoading = false
        }
        
        if let gameName = gameLookupModel?.info?.title {
            await fetchMetacriticDetailsInformation(metacriticLink: tryGenerateMetacriticName(gameName: gameName))
        }
    }
    
    @MainActor
    func fetchGameDetails() async {
        do {
            let endpoint = GamesEndPoint.gameLookup(id: gameId)
            let result = try await gamesService.gameLookup(endpoint: endpoint)
            DispatchQueue.main.async {
                self.gameLookupModel = result
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
    
    func getStore(storeID: String) -> StoresCheapShark? {
        return storesInformations.first(where: { $0.storeID == storeID })
    }
    
    func isCheaper(value: String?) -> Bool {
        guard let valueDouble = Double(value!) else { return false }
        
        let deals = gameLookupModel?.deals
        
        let prices = deals.map { deal in
            deal.map { gamelookup in
                return gamelookup.price
            }
        }
        
        guard let prices else { return false }
        
        for price in prices {
            guard let priceDouble = Double(price!) else { return false }
            if valueDouble < priceDouble {
                return true
            }
        }
        return false
    }
    
    @MainActor
    func fetchMetacriticDetailsInformation(metacriticLink: String) async {
        let baseURL = "https://www.metacritic.com/game"
        
        let url = baseURL + metacriticLink

        let data = await serviceMetacritic.fetchDetailsInformation(metacriticLink: url)
        
        DispatchQueue.main.async {
            self.metacriticDetailModel = data
            self.isLoadingMetacritic = false
        }
    }
    
    func tryGenerateMetacriticName(gameName: String) -> String {
        let removeSpaces = gameName.replacingOccurrences(of: " ", with: "-")
        let newName = removeSpaces.replacingOccurrences(of: ":", with: "")
        return "/\(newName.lowercased())/"
    }
    
    func dateFormatted(dateInt: Int) -> String {
        
        guard let timeInterval = TimeInterval(dateInt.description) else { return "error" }
        
        let date = Date(timeIntervalSince1970: timeInterval)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        
        let dateFormatted = dateFormatter.string(from: date)
        
        return dateFormatted.description
    }
    
    func updateIsFavorite() {
        DispatchQueue.main.async {
            self.isFavorite = CoreDataUseCase.shared.containsFavoriteGame(gameID: self.gameId)
        }
    }
    
    func favoriteAction() {
        do {
            if isFavorite {
                try CoreDataUseCase.shared.deleteFavoriteGame(gameID: gameId)
            } else {
                try CoreDataUseCase.shared.addFavoriteGame(gameID: gameId)
            }
            updateIsFavorite()
            self.hasPerformedAction = true
        } catch {
            print(error)
        }
    }
    
    func reuseFeedGameDealModel(dealModel: DealsGameLookupModel) -> FeedGameDealModel {
        return FeedGameDealModel(gameID: gameId,
                                 dealID: dealModel.dealID ?? "error",
                                 storeID: dealModel.storeID ?? "error",
                                 title: gameLookupModel?.info?.title ?? "error",
                                 salePrice: dealModel.price ?? "error",
                                 normalPrice: dealModel.retailPrice ?? "error",
                                 savings: dealModel.savings ?? "error",
                                 thumb: gameLookupModel?.info?.thumb ?? "error",
                                 metacriticLink: tryGenerateMetacriticName(gameName: "game/\(gameLookupModel?.info?.title ?? "")"))
    }
}
