//
//  ProfileViewModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 22/11/24.
//

import SwiftUI
import PhotosUI

protocol ProfileViewModelProtocol {
    
}

final class ProfileViewModel: ObservableObject, ProfileViewModelProtocol {
    
    @Injected var gamesService: GamesProtocol
    @Injected var formatterUseCase: FormatterProcol
    
    @Published var favoriteGames: [FavoriteGame] = []
    @Published var gamesDetails: MultipleGameLookup?
    @Published private(set) var userImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(imageSelection)
        }
    }
    
    private func setImage(_ image: PhotosPickerItem?) {
        guard let image else { return }
        
        Task {
            if let data = try? await image.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.userImage = uiImage
                    }
                }
            }
        }
    }
    
    func fetchFavoriteGames(completion: @escaping (Result<[FavoriteGame], Error>) -> Void) {
        do {
            let result = try CoreDataUseCase.shared.getFavoriteGames()
            completion(.success(result))
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchGamesDetails() async {
        do {
            let ids = favoriteGames.map { $0.gameID }
            
            let endpoint = GamesEndPoint.multipleGameLookup(ids: ids)
            
            print(endpoint.getUrl())
            let result = try await gamesService.multipleGameLookup(endpoint: endpoint)
            
            if result.isEmpty {
                self.gamesDetails = nil
                return
            }
            
            DispatchQueue.main.async {
                let dictionary = Dictionary(uniqueKeysWithValues: result.compactMap{ $0 })
                self.gamesDetails = MultipleGameLookup(games: dictionary)
            }
        } catch {
            print("Error fetching games details: \(error)")
        }
    }
    
    func setNotification(to: Bool, gameID: String) {
        do {
            try CoreDataUseCase.shared.updateAlertStatus(for: gameID, isActive: to)
        } catch {
            print("Error setting notification: \(error)")
        }
    }
    
    func notificationStatus(for gameID: String) -> Bool {
        do {
            guard let game = try CoreDataUseCase.shared.getFavoriteGame(for: gameID) else { return false }
            return game.notificationIsActive
        } catch {
            print("Error getting notification status: \(error)")
        }
        return false
    }
    
    func favoriteGameIdex(for gameID: String) -> Int? {
        return favoriteGames.firstIndex(where: { $0.gameID == gameID })
    }
    
    func resetData() {
        self.gamesDetails = nil
        self.favoriteGames.removeAll()
    }
}
