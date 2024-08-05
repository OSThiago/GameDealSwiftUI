//
//  Color.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 30/07/24.
//

import Foundation
import SwiftUI

struct SystemColor {
    let positive = Positive()
    let neutral = Neutral()
}

struct Positive {
    let primary = Color(hex: "106C27")
    let secondary = Color(hex: "009C27")
    let tertiary = Color(hex: "D5FFDF")
}

struct Neutral {
    let primary = Color(hex: "A6A6A6")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff
        )
    }
}
