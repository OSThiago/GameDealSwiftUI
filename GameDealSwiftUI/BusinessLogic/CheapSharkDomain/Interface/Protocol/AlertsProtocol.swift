//
//  AlertsProtocol.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 30/09/24.
//

protocol AlertsProtocol {
    func setAlert(email: String, gameID: Int, price: Double) async throws -> Bool
    func removeAlert(email: String, gameID: Int) async throws -> Bool
}
