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

    private let constants = GameDetailConstants()
    
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
                VStack(alignment: .leading, spacing: 16) {
                    headerSection
                    
                    Divider()

                    storesDealsSection
                    
                    GameDetailsSection(metacriticData: viewModel.metacriticDetailModel)
                        .padding(.horizontal, 16)
                }
                
                dismissButton
                    .padding(24)
                    .padding(.top, 16)
            }
            .redacted(reason: viewModel.isLoading == true ? .placeholder : [])
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    GameDetailConfigurator(gameId: "206126").configure()
}
