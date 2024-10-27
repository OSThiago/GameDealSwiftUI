//
//  View+onBackSwipe.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 20/07/23.
//

import SwiftUI

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
