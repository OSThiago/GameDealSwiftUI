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
    
    @State var scrollDisable = false
    
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
            .background(GeometryReader { geometry in
                Color.clear
                    .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named(constants.scrollkey)).origin)
            })
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                self.viewModel.scrollPosition = value
                if value.y > -59 {
                    scrollDisable = true
                } else {
                    scrollDisable = false
                }
                print(value.y)
            }
            .redacted(reason: viewModel.isLoading == true ? .placeholder : [])
        }
        .scrollDisabled(scrollDisable)
        .ignoresSafeArea(edges: .top)
        .coordinateSpace(name: constants.scrollkey)
        .swipe(down: {
            if viewModel.scrollPosition.y >= -59 {
                router.dismissFullScreenCover()
                print("swipDown")
            }
        })
    }
}

#Preview {
    GameDetailConfigurator(gameId: "206126").configure()
}


extension View {
    func swipe(
        up: @escaping (() -> Void) = {},
        down: @escaping (() -> Void) = {},
        left: @escaping (() -> Void) = {},
        right: @escaping (() -> Void) = {}
    ) -> some View {
        return self.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onEnded({ value in
                if value.translation.width < 0 { left() }
                if value.translation.width > 0 { right() }
                if value.translation.height < 0 { up() }
                if value.translation.height > 0 { down() }
            }))
    }
}
