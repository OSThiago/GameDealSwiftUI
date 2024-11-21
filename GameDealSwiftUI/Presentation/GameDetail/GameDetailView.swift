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

    let constants = GameDetailConstants()
    
    init(viewModel: GameDetailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content
            .statusBarHidden()
            .task {
                await viewModel.viewDidLoad()
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
                    
                    GameDetailsSection(metacriticData: viewModel.metacriticDetailModel)
                        .padding(.horizontal, Tokens.padding.xxxs)
                }
                
                dismissButton
                    .padding(Tokens.padding.xxs)
                    .padding(.top, Tokens.padding.xxxs)
            }
            .redacted(reason: viewModel.isLoading == true ? .placeholder : [])
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    GameDetailConfigurator(gameId: "206126").configure()
}
