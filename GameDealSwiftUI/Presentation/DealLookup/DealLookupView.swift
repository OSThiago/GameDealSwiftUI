//
//  DealLookupView.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 27/06/23.
//

import SwiftUI

struct DealLookupView: View {
    // MARK: - PROPERTIES
    @StateObject var viewModel = DealLookupViewModel()
    @Environment (\.presentationMode) var presentation
    
    let feedGameDealModel: FeedGameDealModel
    
    // MARK: - INITIALIZER
    init(feedGameDealModel: FeedGameDealModel) {
        self.feedGameDealModel = feedGameDealModel
    }
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                makeSectionDeailDetail()
            }
            .onAppear {
                viewModel.setupView(feedGameDealModel: self.feedGameDealModel)
            }
            // Custom swipe back action
            .onBackSwipe {
                presentation.wrappedValue.dismiss()
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        // MARK: - TOOL BAR
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                makeBackButton()
            }
        }
    }
    
    // MARK: - BACK BUTTON
    @ViewBuilder
    private func makeBackButton() -> some View {
        Button {
            presentation.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.backward.circle.fill")
                .foregroundColor(.gray)
        }
    }
}

struct DealLookupView_Previews: PreviewProvider {
    static var previews: some View {
        DealLookupView(feedGameDealModel: FeedGameDealModel.riseOfIndustryMock)
    }
}
