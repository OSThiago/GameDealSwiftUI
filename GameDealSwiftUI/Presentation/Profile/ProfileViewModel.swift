//
//  ProfileViewModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 22/11/24.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    
    @Injected var gamesService: GamesProtocol
    
    @Published var favoriteGames: [FavoriteGame] = []
    @Published var gamesDetails: MultipleGameLookup?
    
    func fetchFavoriteGames(completion: @escaping (Result<[FavoriteGame], Error>) -> Void) {
        do {
            let result = try CoreDataProvider.shared.getFavoriteGames()
            completion(.success(result))
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchGamesDetails() async {
        do {
            let ids = favoriteGames.map { $0.gameID }
            
            let endpoint = GamesEndPoint.multipleGameLookup(ids: ids)
            
            let result = try await gamesService.multipleGameLookup(endpoint: endpoint)
            DispatchQueue.main.async {
                let dictionary = Dictionary(uniqueKeysWithValues: result.compactMap{ $0 })
                self.gamesDetails = MultipleGameLookup(games: dictionary)
            }
        } catch {
            print(error)
        }
    }
}
