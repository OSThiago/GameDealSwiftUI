//
//  TestGameDetailRawg.swift
//  GameDealSwiftUITests
//
//  Created by Thiago de Oliveira Sousa on 11/07/23.
//

import XCTest
@testable import GameDealSwiftUI

final class TestGameDetailRawg: XCTestCase {
    
    var network: WorkerRAWG!
    
    override func setUpWithError() throws {
        self.network = WorkerRAWG()
    }

    override func tearDownWithError() throws {
        self.network = nil
    }

    func testGetGameDetailSucess() async throws {
        
        let expectationDescription = expectation(description: "fetch game detail sucess")
        
        let expectationGameName = RwGameDetailModel.MortalKombatXL.name
        
        let endpoint = EndpointCasesRAWG.getGameDetail(name: "Mortal Kombat XL")
        
        //var gameName = ""
        
        network.getGameDetail(endpoint: endpoint) { result in
            switch result {
            case .success(let game):
                XCTAssertEqual(game.name, expectationGameName)
            case .failure(_):
                XCTFail()
            }
            expectationDescription.fulfill()
        }
        
        await self.waitForExpectations(timeout: 3.0)
        
        //XCTAssertEqual(gameName, expectationGameName)
    }
}
