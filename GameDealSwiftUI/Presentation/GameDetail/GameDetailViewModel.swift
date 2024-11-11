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
    
    @Published var gameLookupModel: GameLookupModel?
    
    var gameId: String
    
    init(gameid: String) {
        self.gameId = gameid
    }
    
    func viewDidLoad() async {
        await fetchGameDetails()
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
}
