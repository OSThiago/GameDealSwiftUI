//
//  RedirectProtocol.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 06/01/25.
//

import Foundation

protocol RedirectProtocol {
    func getDealWebLink(endpoint: RedirectEndpoint) -> String
}
