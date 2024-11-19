//
//  GameDetailItem.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 18/11/24.
//

import SwiftUI

struct GameDetailItem: View {
    
    let items: [String]
    let title: String
    
    @State var isExpanded: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            collapsed
            if isExpanded {
                expanded
            }
        }
    }
}

extension GameDetailItem {
    var collapsed: some View {
        HStack {
            // Title
            Text("\(title)")
                .font(.body)
                .fontWeight(.medium)
                .fontDesign(.rounded)
                .foregroundStyle(.gray)
            
            Spacer()
            
            // preview
            if !isExpanded {
                if let firstItem = items.first {
                    HStack(spacing: 4) {
                        Text(firstItem)
                            .font(.body)
                            .fontWeight(.regular)
                            .fontDesign(.rounded)
                            .lineLimit(1)
                        
                        if items.count > 1 {
                            Text("and \(items.count - 1) more")
                        }
                    }
                    .frame(width: 190, alignment: .trailing)
                }
            }

            // Expand Button
            Button {
                withAnimation {
                    isExpanded.toggle()
                }
            } label: {
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundStyle(.gray)
            }
        }
    }
}

extension GameDetailItem {
    var expanded: some View {
//        VStack {
            Text(items.joined(separator: ", "))
            .frame(height: 80, alignment: .topLeading)
//        }
//        .frame(maxHeight: 100)
    }
}

#Preview {
    GameDetailItem(items: MetacriticDetailModel.thewitcher3.platforms ?? [],
                   title: "Plarforms")
    .padding(.horizontal, 16)
}
