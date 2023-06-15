//
//  Response.swift
//  GameDealSwiftUI
//
//  Created by Thiago de Oliveira Sousa on 15/06/23.
//

import Foundation

enum Response<Success, Failure> where Failure: Error {
    case success(Success)
    case failure(Failure)
}
