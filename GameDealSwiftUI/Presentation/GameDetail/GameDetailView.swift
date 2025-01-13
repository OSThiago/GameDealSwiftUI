//
//  GameDetailView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 08/11/24.
//

import SwiftUI

struct GameDetailView: View {
    
    @EnvironmentObject var router: Router
    
    @StateObject var viewModel: GameDetailViewModel

    @State private var offset: CGFloat = 0
    
    let constants = GameDetailConstants()
    
    var onDisappear: (() -> Void)?
    
    init(viewModel: GameDetailViewModel,
         onDisappear: (() -> Void)? = nil
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.onDisappear = onDisappear
    }
    
    var body: some View {
        content
            .statusBarHidden()
            .task {
                await viewModel.viewDidLoad()
            }
            .onDisappear {
                if let onDisappear {
                    onDisappear()
                }
            }
            
    }
}

extension GameDetailView {
    var content: some View {
        ScrollView {
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .leading, spacing: Tokens.padding.xxxs) {
                    headerSection
                    
                    Divider()

                    storesDealsSection
                    
                    if viewModel.isLoadingMetacritic {
                        ProgressView()
                            .frame(maxWidth: ScreenSize.width, alignment: .center)
                    } else {
                        GameDetailsSection(metacriticData: viewModel.metacriticDetailModel)
                            .padding(.horizontal, Tokens.padding.xxxs)
                    }
                }
            }
            .redacted(reason: viewModel.isLoading == true ? .placeholder : [])
        }
        .navigationTitle(viewModel.gameLookupModel?.info?.title ?? "")
        .toolbarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    GameDetailConfigurator(gameId: "206126", onDisappear: nil).configure()
}
