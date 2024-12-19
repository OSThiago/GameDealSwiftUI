//
//  EmptyState.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 19/12/24.
//

import SwiftUI

struct EmptyState: View {
    
    let title: String?
    let description: String?
    let icon: String?
    
    init(title: String? = nil,
         description: String? = nil,
         icon: String? = nil
    ) {
        self.title = title
        self.description = description
        self.icon = icon
    }
    
    var body: some View {
        VStack {
            if let icon = icon {
                ZStack {
                    Circle()
                        .frame(width: 150)
                        .foregroundStyle(.gray.opacity(0.2))
                    
                    Image(systemName: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }
                .padding(.bottom, 16)
            }
            
            if let title = title {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            
            if let description = description {
                Text(description)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    VStack {
        EmptyState(title: "No Games",
                   description: "Add games to your favorite list",
                   icon: "gamecontroller.fill")
    }
}

#Preview {
    EmptyState(title: "No Games",
               description: "Add games to your favorite list")
}
