//
//  DealLookupView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 27/06/23.
//

import SwiftUI

struct DealLookupView: View {
    
    @StateObject var viewModel = DealLookupViewModel()
    @Environment (\.presentationMode) var mode
    
    let feedGameDealModel: FeedGameDealModel
    
    init(feedGameDealModel: FeedGameDealModel) {
        self.feedGameDealModel = feedGameDealModel
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                makeSectionDeailDetail()
            }
            .onAppear {
                viewModel.fetchStoresInformations()
                viewModel.feedGameDealModel = feedGameDealModel
                viewModel.fetchDealLookup(gameID: feedGameDealModel.gameID)
                
                //viewModel.fetchGameDetailFromRawg()
                viewModel.fetchSearchDetailRawg(gameName: viewModel.feedGameDealModel?.title ?? "")
            }
            // Custom Action to Swipe back
            .onBackSwipe {
                mode.wrappedValue.dismiss()
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct DealLookupView_Previews: PreviewProvider {
    static var previews: some View {
        DealLookupView(feedGameDealModel: FeedGameDealModel.riseOfIndustryMock)
    }
}

extension View {
    func onBackSwipe(perform action: @escaping () -> Void) -> some View {
        gesture(
            DragGesture()
                .onEnded({ value in
                    if value.startLocation.x < 50 && value.translation.width > 80 {
                        action()
                    }
                })
        )
    }
}
