//
//  TestGameLookUp.swift
//  GameDealSwiftUITests
//
//  Created by Thiago de Oliveira Sousa on 26/06/23.
//

import XCTest
@testable import GameDealSwiftUI

final class TestGameLookUp: XCTestCase {
    
    var network: WorkerCheapShark!
    
    override func setUpWithError() throws {
        self.network = WorkerCheapShark()
    }

    override func tearDownWithError() throws {
        self.network = nil
    }
    
    func testGetValidGameLookUp() async throws {
        
        let expectation = expectation(description: "Fetch game Lookup")
        
        let expectationGameTitle = "The Sims 4 Horse Ranch Expansion Pack"
        
        let gameID = "265723"
        
        let endpoint = EndpointCasesCheapShark.getGameLookup(gameID)
        
        var game: GameLookupModel?
        
        network.getGameLookup(endpoint: endpoint) { result in
            switch result {
            case .success(let gameData):
                //game = gameData
                XCTAssertEqual(gameData.info?.title, expectationGameTitle)
            case .failure(_):
                XCTFail()
            }
            expectation.fulfill()
        }
        
        await self.waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(game?.info?.title, expectationGameTitle)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

//func testGetStores() async throws {
//
//    let expectation = expectation(description: "Fetch Stores informatinos")
//
//    var stores = [StoresCheapShark]()
//
//    worker.getStores() { result in
//
//        switch result {
//        case .success(let storesResult):
//            stores.append(contentsOf: storesResult)
//        case .failure(_):
//            XCTFail()
//        }
//        expectation.fulfill()
//    }
//
//
//    await self.waitForExpectations(timeout: 3.0)
//
//    XCTAssert(!stores.isEmpty)
//
//    XCTAssertEqual(stores[0].storeName, StoresCheapShark.steamMock.storeName)
//}
