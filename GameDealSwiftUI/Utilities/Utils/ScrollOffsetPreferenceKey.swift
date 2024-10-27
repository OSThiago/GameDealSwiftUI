//
//  ScrollOffsetPreferenceKey.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 08/08/24.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}
