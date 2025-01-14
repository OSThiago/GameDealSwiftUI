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

enum ProfileSheet: Identifiable {
    case profile, cover
    
    var id: Int {
        hashValue
    }
}

final class ProfileViewModel: ObservableObject, ProfileViewModelProtocol {
    
    @Injected var gamesService: GamesProtocol
    @Injected var formatterUseCase: FormatterProcol
    @Injected var userDefault: UserDefaultProtocol
    
    // State
    @Published var isRedected = true
    @Published var activeSheet: ProfileSheet?
    // Data
    @Published var favoriteGames: [FavoriteGame] = []
    @Published var gamesDetails: MultipleGameLookup?
    // Favorite games
    @Published var onSaleGames: [String : GameLookup] = [:]
    @Published var noDealsGames: [String : GameLookup] = [:]
    // Profile Info
    @Published var userName: String = "Your Name"
    // Images
    @Published private(set) var userImage: UIImage? = nil
    @Published private(set) var coverImage: UIImage? = nil
    @Published var userImageSelection: PhotosPickerItem? = nil {
        didSet {
            setUserImage(userImageSelection)
        }
    }
    @Published var coverImageSelection: PhotosPickerItem? = nil {
        didSet {
            setCoverImage(coverImageSelection)
        }
    }
    
    func configure() {
        self.userName = userDefault.getUserName()
        self.userImage = userDefault.getImage(key: .userImage)
        self.coverImage = userDefault.getImage(key: .coverImage)
    }
    
    private func setUserImage(_ image: PhotosPickerItem?) {
        guard let image else { return }
        
        Task {
            if let data = try? await image.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.userImage = uiImage
                        self.userDefault.saveImage(key: .userImage,
                                                   image: uiImage)
                    }
                }
            }
        }
    }
    
    private func setCoverImage(_ image: PhotosPickerItem?) {
        guard let image else { return }
        
        Task {
            if let data = try? await image.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.coverImage = uiImage
                        self.userDefault.saveImage(key: .coverImage,
                                                   image: uiImage)
                    }
                }
            }
        }
    }
    
    func removeProfileImage() {
        self.userImageSelection = nil
        self.userImage = nil
        self.userDefault.saveImage(key: .userImage,
                                   image: nil)
    }
    
    func removeCoverImage() {
        self.coverImageSelection = nil
        self.coverImage = nil
        self.userDefault.saveImage(key: .coverImage,
                                   image: nil)
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

            let result = try await gamesService.multipleGameLookup(endpoint: endpoint)
            
            if result.isEmpty {
                self.gamesDetails = nil
                return
            }

            DispatchQueue.main.async {
                let dictionary = Dictionary(uniqueKeysWithValues: result.compactMap{ $0 })
                self.gamesDetails = MultipleGameLookup(games: dictionary)
                self.updateOnSale()
                self.updateNoDeals()
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
        self.onSaleGames.removeAll()
        self.noDealsGames.removeAll()
    }
    
    func updateOnSale() {
        guard let games = self.gamesDetails?.games else { return }
        
        self.onSaleGames.removeAll()
        
        let filtered = games.filter { id, game in
            if let first = game.deals.first {
                return first.retailPrice != first.price
            }
            return false
        }
        
        DispatchQueue.main.async {
            self.onSaleGames = filtered
        }
    }
    
    func updateNoDeals() {
        guard let games = self.gamesDetails?.games else { return }
        
        self.noDealsGames.removeAll()
        
        let filtered = games.filter { id, game in
            if let first = game.deals.first {
                return first.retailPrice == first.price
            }
            return false
        }
        
        DispatchQueue.main.async {
            self.noDealsGames = filtered
        }
    }
    
    func updateRedectedState() -> Bool {
        if gamesDetails == nil {
            return true
        } else {
            return false
        }
    }
}
