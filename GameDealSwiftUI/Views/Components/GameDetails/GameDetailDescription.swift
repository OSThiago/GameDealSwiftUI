//
//  GameDetailDescription.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa - TOI on 18/11/24.
//

import SwiftUI

struct GameDetailDescription: View {
    
    @Injected private var formatterUseCase: FormatterProcol
    
    let description: String
    
    @State var isExpanded: Bool = false

    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text("Description")
                    .font(.body)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .foregroundStyle(.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    // Expand Button
                    Button {
                        isExpanded.toggle()
                    } label: {
                        Text(isExpanded ? "Less" : "More")
                    }
                }
            }
            
            Text(formatterUseCase.descriptionFormatted(description: description))
                .frame(maxWidth: .infinity, maxHeight: isExpanded ? nil : 100, alignment: .topLeading)
        }
    }
}

#Preview {
    GameDetailDescription(description: MetacriticDetailModel.thewitcher3.description ?? "")
        .padding(.horizontal, 16)
}
