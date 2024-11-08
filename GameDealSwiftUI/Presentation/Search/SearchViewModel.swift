//
//  SearchViewModel.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 04/11/24.
//

import SwiftUI
import Combine

protocol SearchViewModelProtocol {
    var games: [GameModel] { get set }
    var viewState: ViewState { get set }
    var searchText: String { get set }
    var isEmptyState: Bool { get set }
    var isNoResult: Bool { get set }
    
    func viewDidLoad() async
    func searchGame(_ name: String) async
}

final class SearchViewModel: ObservableObject, SearchViewModelProtocol {

    @Injected var gamesService: GamesProtocol
    @Injected var formatterUsecase: FormatterProcol

    @Published var games: [GameModel] = []
    @Published var viewState: ViewState = .loading
    @Published var searchText = ""
    @Published var isEmptyState = false
    @Published var isNoResult = false

    private var cancellables = Set<AnyCancellable>()

    func viewDidLoad() async {
        DispatchQueue.main.async {
            self.updateEmptyState()
            self.viewState = .loaded
        }

        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                Task {
                    await self?.searchGame(query)
                }
            }
            .store(in: &cancellables)
    }

    func searchGame(_ name: String) async {
        DispatchQueue.main.async {
            self.games.removeAll()
            self.viewState = .loading
        }

        do {
            let endpoint = GamesEndPoint.gamesList(queryItens: [.title(title: name)])
            let result = try await gamesService.gamesList(endpoint: endpoint)
            
            DispatchQueue.main.async {
                self.games.append(contentsOf: result)
                self.updateEmptyState()
                self.viewState = .loaded
            }
        } catch {
            self.viewState = .error
            print(error)
        }
    }

    func updateEmptyState() {
        if searchText.isEmpty {
            self.isEmptyState = true
        } else {
            self.isEmptyState = false
        }

        if !searchText.isEmpty && games.isEmpty {
            self.isNoResult = true
        } else {
            self.isNoResult = false
        }
    }
}
