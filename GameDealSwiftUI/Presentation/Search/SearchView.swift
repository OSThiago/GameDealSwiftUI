//
//  SearchView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 04/11/24.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var router: Router
    @StateObject var viewModel: SearchViewModel
    
    private var constants = SearchConstants()
    
    init(viewModel: SearchViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        buildedContent
            .task {
                await viewModel.viewDidLoad()
            }
            .searchable(text: $viewModel.searchText, prompt: constants.searchbarPlaceholder)
            .onChange(of: viewModel.searchText) {
                viewModel.viewState = .loading
                viewModel.updateEmptyState()
            }
            .navigationTitle(constants.navigationTitle)
    }
}

// MARK: - BuildedContent
extension SearchView {
    @ViewBuilder
    var buildedContent: some View {
        switch viewModel.viewState {
        case .loading:
            ProgressView()
        case .loaded:
            content
        case .error:
            Text("Error")
        }
    }
}

// MARK: - Content
extension SearchView {
    @ViewBuilder
    var content: some View {
        if viewModel.isEmptyState {
            emptyState(title: constants.emptyTitle,
                       description: constants.emptyDescription)
        } else if viewModel.isNoResult {
            emptyState(title: constants.emptyResultTitle,
                       description: constants.emptyResultDescription(text: viewModel.searchText))
        } else {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.games, id: \.gameID) { game in
                        gameCell(thumb: viewModel.formatterUsecase.getHightQualityImage(url: game.thumb ?? "" ),
                                 name: game.external ?? "")
                        .onTapGesture {
                            router.present(fullScreenCover: .gameDetail(gameID: game.gameID ?? "", onDisappear: nil))
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Game Cell
extension SearchView {
    func gameCell(thumb: String, name: String) -> some View {
        HStack(spacing: Tokens.padding.nano) {
            gameImage(thumb: thumb)
            
            Text(name)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(2)
        }
        .padding(.horizontal, Tokens.padding.xxxs)
    }
    
    @ViewBuilder
    func gameImage(thumb: String) -> some View {
        let imageWidth: CGFloat = 60 * 16/9
        let imageHeight: CGFloat = 60
        
        AsyncImage(url: URL(string: thumb)) { phase in
            switch phase  {
            case .empty:
                ProgressView()
                    .frame(width: imageWidth, height: imageHeight)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageWidth, height: imageHeight)
                    .clipped()
                    .cornerRadius(Tokens.borderRadius.sm)
                    
            case .failure(_):
                // TODO: Criar ou adicionar em um token de simbolos
                Image(systemName: "photo.artframe")
                    .frame(width: imageWidth, height: imageHeight)
                    .foregroundStyle(Tokens.color.neutral.primary)
            @unknown default:
                Image(systemName: "photo.artframe")
                    .frame(width: imageWidth, height: imageHeight)
                    .foregroundStyle(Tokens.color.neutral.primary)
            }
        }
    }
}

extension SearchView {
    func emptyState(title: String, description: String?) -> some View {
        VStack {
            Text(title)
                .fontWeight(.semibold)

            if let description = description {
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    
            }
        }
    }
}

#Preview {
    var viewModel = SearchViewModel()
    viewModel.viewState = .loaded
    viewModel.games = [.witcher2Mock]
    return SearchView(viewModel: viewModel)
}
