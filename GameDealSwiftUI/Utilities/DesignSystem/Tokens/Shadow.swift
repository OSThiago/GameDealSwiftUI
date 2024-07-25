//
//  Shadow.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 24/07/24.
//

import SwiftUI

// MARK: - Token

enum ShadowLevel {
    static let level1 = ShadowStyle(x: 0, y: 4, blur: 8, color: .black.opacity(0.08))
    
    static let level2 = ShadowStyle(x: 0, y: 8, blur: 24, color: .black.opacity(0.16))
    
    static let level3 = ShadowStyle(x: 0, y: 16, blur: 32, color: .black.opacity(0.16))
    
    static let level4 = ShadowStyle(x: 0, y: 16, blur: 48, color: .black.opacity(0.24))

}

public struct ShadowStyle {
    let x: CGFloat
    let y: CGFloat
    let blur: CGFloat
    let color: Color
}

// MARK: - ViewModifier

struct ShadowStyleModifier: ViewModifier {
    
    let style: ShadowStyle
    
    func body(content: Content) -> some View {
        content
            .shadow(
                color: style.color,
                radius: style.blur,
                x: style.x,
                y: style.y
            )
    }
}

public extension View {
    func shadow(_ style: ShadowStyle) -> some View {
        modifier(
            ShadowStyleModifier(style: style)
        )
    }
}
