//
//  Array+uiniqued.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 15/10/24.
//

import Foundation

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
