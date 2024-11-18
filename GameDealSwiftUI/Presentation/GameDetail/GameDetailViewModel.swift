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
    
    var gameId: String { get }
    var gameLookupModel: GameLookupModel? { get set }
}

final class GameDetailViewModel: ObservableObject, GameDetailViewModelProtocol {
    
    @Injected var gamesService: GamesProtocol
    @Injected var serviceStores: StoresProtocol
    @Injected var formatterUseCase: FormatterProcol
    
    @Published var gameLookupModel: GameLookupModel?
    @Published var storesInformations: [StoresCheapShark] = []
    
    var gameId: String
    
    init(gameid: String) {
        self.gameId = gameid
    }
    
    func viewDidLoad() async {
        await fetchGameDetails()
        await fetchStoresInformations()
    }
    
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
}
